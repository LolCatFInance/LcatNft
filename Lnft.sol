// SPDX-License-Identifier: GNU
pragma solidity ^0.8.0;

import "./ERC721.sol";
import "./Ownable.sol";
contract Lnft is ERC721,Ownable{
    event NftMinted(address indexed Minter,uint256 indexed TokenId,address indexed recipient,uint256  MintDate);
    event NftBurned(address indexed Burner,uint256 indexed TokenId,uint256 BurnDate,bool indexed IsOwnerBurned);
    event IpfsUpdate(address indexed Updater,uint256 indexed TokenId,uint256 UpdateDate,string  indexed PreviousIpfs,string  NewIpfs);
    constructor() ERC721("DotMatrix NFT","DM"){
        
    }
    function MintNft(address To,uint256 TokenId,string memory IpfsInfo)public onlyOwner returns(bool){
        require(_safeMint(To,TokenId,""));
        TokenIpfs[TokenId]=IpfsInfo;
        emit NftMinted(msg.sender,TokenId,To,block.timestamp);
        return true;
        
    }
    function BurnNftByOwner(uint256 TokenId) public onlyOwner returns(bool){
        _burn(TokenId);
        emit NftBurned(msg.sender,TokenId,block.timestamp,true);
        return true;
    }
    function BurnNft(uint256 TokenId)public onlyOwner returns(bool){
    require(_isApprovedOrOwner(_msgSender(),TokenId),"Unautorized Request");
        _burn(TokenId);
        emit NftBurned(msg.sender,TokenId,block.timestamp,false);
        return true;
    }
    function UpdateIpfsInfo(uint256 TokenId,string memory NewIpfsInfo)public onlyOwner returns(bool){
        string memory PreviousIpfs=TokenIpfs[TokenId];
        TokenIpfs[TokenId]=NewIpfsInfo;
        emit IpfsUpdate(msg.sender,TokenId,block.timestamp,PreviousIpfs,NewIpfsInfo);
        return true;
    }
    function UpdateBaseUrI(string memory NewBaseUrI)public onlyOwner returns(bool){
        BaseUrI=NewBaseUrI;
        return true;
    }
} 