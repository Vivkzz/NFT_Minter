// This is a basic React app for minting NFTs. It's not fancy, just a simple demo.
// It lets you connect your wallet, upload an image, and mint an NFT to your address.

import React, { useState } from "react";
import { ethers } from "ethers";
import { CONTRACT_ADDRESS, ABI } from "./utils/contract";
import axios from "axios";

function App() {
    const [account, setAccount] = useState("");
    const [file, setFile] = useState(null);
    const [minting, setMinting] = useState(false);
    const [connecting, setConnecting] = useState(false);

    // MetaMask part 
    const connectWallet = async () => {
        if (window.ethereum && !account && !connecting) {
            setConnecting(true);
            try {
                const [selectedAccount] = await window.ethereum.request({ method: "eth_requestAccounts" });
                setAccount(selectedAccount);
            } catch (err) {
                alert("Connect failed: " + (err && err.message ? err.message : JSON.stringify(err)));
            }
            setConnecting(false);
        }
    };

    //  Pinata part  (reference: pinata docs)
    const uploadToIPFS = async (file) => {
        const formData = new FormData();
        formData.append("file", file); const res = await axios.post("https://api.pinata.cloud/pinning/pinFileToIPFS", formData, {
            maxContentLength: "Infinity",
            headers: {
                "Content-Type": `multipart/form-data; boundary=${formData._boundary}`,
                "pinata_api_key": process.env.REACT_APP_PINATA_API_KEY,
                "pinata_secret_api_key": process.env.REACT_APP_PINATA_SECRET_API_KEY,
            },
        });
        return `https://gateway.pinata.cloud/ipfs/${res.data.IpfsHash}`;
    };

    const mintNFT = async () => {
        if (!file || !account) return;
        setMinting(true);
        try {
            const imageUrl = await uploadToIPFS(file);
            const provider = new ethers.BrowserProvider(window.ethereum);
            const signer = await provider.getSigner();
            const contract = new ethers.Contract(CONTRACT_ADDRESS, ABI, signer);
            const tx = await contract.mint(account, imageUrl, { value: ethers.parseEther("0.01") });
            await tx.wait();
            alert("NFT Minted!");
        } catch (err) {
            alert("Mint failed: " + (err && err.message ? err.message : JSON.stringify(err)));
        }
        setMinting(false);
    };

    return (
        <div className="app-container">
            <h1>Simple NFT Minter (MVP)</h1>
            {!account ? (
                <button onClick={connectWallet} disabled={connecting}>
                    {connecting ? "wallet is lock or accept req on wallet" : "Connect Wallet"}
                </button>
            ) : (
                <div>
                    <p>Connected: {account}</p>
                    <input type="file" accept="image/*" onChange={e => setFile(e.target.files[0])} />
                    {file && (
                        <div className="nft-preview">
                            <img src={URL.createObjectURL(file)} alt="Preview" />
                            <span>Preview</span>
                        </div>
                    )}
                    <button onClick={mintNFT} disabled={minting || !file}>
                        {minting ? "Minting..." : "Mint NFT"}
                    </button>
                </div>
            )}
        </div>
    );
}

export default App;