from brownie import Voting, accounts

def main():
    dev = accounts[0]
    candidates = ["Atiku", "Tinubu", "Obi"]

    # Check if there are any deployed Voting contracts
    if len(Voting) == 0:
        print("No voting contract deployed. Deploying a new one...")
        voting = Voting.deploy(candidates, {'from': dev})
        print(f'Contract deployed at {voting.address}')
    else:
        voting = Voting[-1]  # Get the most recently deployed Voting contract

    # Vote for a candidate
    candidate = "Tinubu"
    tx = voting.vote(candidate, {'from': dev})
    tx.wait(1)

    # Check votes
    votes = voting.votes(candidate)
    print(f"{candidate} has {votes} votes.")
