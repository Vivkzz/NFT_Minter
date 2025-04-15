# Simple NFT Minter

This is a basic project that lets you mint your own NFTs on the blockchain. It includes a simple smart contract and a React frontend. You can connect your wallet, upload an image, and mint an NFT to your address.

## Features

- Connect your MetaMask wallet
- Upload an image (stored on IPFS via Pinata)
- Mint an NFT to your wallet for a fixed price (0.01 ETH)
- Simple and clean UI

## How to Run

### 1. Clone the repository

```sh
git clone https://github.com/Vivkzz/NFT_Minter.git
cd NFT_Minter
```

### 2. Install dependencies

For the frontend:
```sh
cd frontend
npm install
```

For the smart contract (if you want to deploy/test):
```sh
cd ..
# Install dependencies as needed for your contract environment (e.g., Foundry, Hardhat, etc.)
```

### 3. Set up environment variables

Create a `.env` file in the `frontend` folder with your Pinata API keys:

```
REACT_APP_PINATA_API_KEY=your_pinata_api_key
REACT_APP_PINATA_SECRET_API_KEY=your_pinata_secret_api_key
```

### 4. Start the frontend

```sh
cd frontend
npm start
```

Open [http://localhost:3000](http://localhost:3000) in your browser.

## Usage

1. Click "Connect Wallet" and approve in MetaMask.
2. Upload an image file.
3. Click "Mint NFT" (make sure you have some test ETH).
4. Wait for the transaction to complete. Your NFT is minted!

## Notes

- This is a beginner-friendly project, not meant for production.
- The smart contract is very simple and uses OpenZeppelin ERC721.
- All images are uploaded to IPFS using Pinata.
- You need ETH on the network where the contract is deployed (e.g., testnet).

## License

MIT

---

Made by Vivek Tanna for learning and demo purposes.