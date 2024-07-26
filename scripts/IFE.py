from brownie import Ifelse, accounts

def main():
    _num = 6

    dev_account = accounts[0]

    IFELSE = Ifelse.deploy({'from': dev_account})
    IFELSE.get(_num,{'from': dev_account})
    print("contract successfully deployed @ :", IFELSE.address)
    print("confirmed:", IFELSE.myString())