import subprocess
import re
import requests


def find_link_in_output(output):
    # check is done without errors
    if "Done, without errors." not in output:
        raise Exception("some issue with creating new user")
    pattern = "http://localhost:8080//user/password/set\?passwordResetToken=.*"

    # Use re.findall to extract all matching substrings
    matches = re.findall(pattern, output)
    # print(len(matches))
    # print(matches[0])
    return matches[0].replace("localhost:8080//user/password", "localhost:8080/user/password")


def find_csrf_passwordReset_tokens(response):
    # window.csrfToken = "DwSsXuVc-uECsSv6dW5ifI4025HacsODuhb8"
    # decoded_data = response.decode('utf-8')
    csrf_token = re.search('window.csrfToken = "([^"]+)"', response, re.IGNORECASE)
    assert csrf_token, "No csrf token found in response"
    passwordReset_token = re.search('name="passwordResetToken" value="([^"]+)"', response, re.IGNORECASE)
    return csrf_token.group(1), passwordReset_token.group(1)

def get_user_credentials(i):
    return ("user{}@netsail.uci.edu".format(str(i)), "iamuser{}".format(str(i)))


username, password = get_user_credentials(4)

print("Trying to add new user with credentials username: {} and password: {}".format(username, password))

# Define the Bash command you want to run
command = "docker exec -it sharelatex-dockerized_web_1 grunt user:create-admin --email {}".format(username)

# # Run the command and capture the output
output = subprocess.check_output(command, shell=True, text=True)

# # Print or store the output
print("Successfully, created new username...")
print("Now adding password..")

url = find_link_in_output(output)
print(url)

session = requests.Session()  # Create a session to persist cookies
response = session.get(url)
#print(str(response.content))
csrf, reset = find_csrf_passwordReset_tokens(str(response.content))

data = {"_csrf":csrf,"password":password,"passwordResetToken":reset}
post_url = "http://localhost:8080/user/password/set"

response = session.post(post_url, data=data)
if "Your password has been reset" not in str(response.content):
    raise Exception("some issue with setting {}'s password".format(username))
else:
    print("Successfully, added password for {}...".format(username))

session.close()

print("Credentials are: \n username: ")