from brownie import Array, accounts

def main():

    arr = [3,5,6,9]
    i = arr[1]
    arr.append(10)
    len(arr)
    arr.remove(6)

    # Get the first account from the list of accounts
    deployer_account = accounts[0]

    hello = Array.deploy({'from': deployer_account})
    hello.get(i, {'from': deployer_account[0]})
    print("contract deployed at:", hello.address)
    print(arr[0])
    print(arr)
    print(arr.pop())
    print(len(arr))
