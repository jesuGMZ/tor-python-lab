import stem.process
import requests

# default Tor client port
SOCKS_PORT = 9050
PROXIES = {'https': 'socks5://127.0.0.1:' + str(SOCKS_PORT)}


def print_bootstrap_lines(line):
    if 'Bootstrapped ' in line:
        print(line)

# start an instance of Tor
tor_process = stem.process.launch_tor_with_config(
    config={'SocksPort': str(SOCKS_PORT)},
    init_msg_handler=print_bootstrap_lines
)

# print the current IP is being used through Tor
print(requests.get('https://httpbin.org/ip', proxies=PROXIES).text)

# stops Tor client
tor_process.kill()
