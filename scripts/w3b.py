from brownie import Voting, accounts

def main():

    # deploy contract
    dev = accounts[0]

    candidates = ["Atiku", "Tinubu", "Obi"]

    # deploy the contract
    voting = Voting.deploy(candidates,{"from": dev})

    print(f'Contract deployed at {voting.address}')
