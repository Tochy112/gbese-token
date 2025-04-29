// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import "@openzeppelin/contracts/utils/Base64.sol";
import "@openzeppelin/contracts/utils/Strings.sol";
import "@openzeppelin/contracts/access/Ownable.sol";

contract GbeseToken is ERC20, Ownable {
    string private _tokenName;
    string private _tokenDescription;
    string private _tokenImage;

    constructor(
        string memory name_,
        string memory symbol_,
        string memory description_,
        string memory imageUrl_
    ) ERC20(name_, symbol_) Ownable(msg.sender) {
        _mint(msg.sender, 1000000 * (10 ** uint256(decimals())));
        _tokenName = name_;
        _tokenDescription = description_;
        _tokenImage = imageUrl_;
    }

    function tokenURI() public view returns (string memory) {
        bytes memory metadata = abi.encodePacked(
            '{"name": "', _tokenName,
            '", "description": "', _tokenDescription,
            '", "image": "', _tokenImage,
            '", "decimals": ', Strings.toString(decimals()),
            '}'
        );

        return string(
            abi.encodePacked(
                "data:application/json;base64,",
                Base64.encode(metadata)
            )
        );
    }

    /**
     * @dev Updates the token metadata. Only callable by the owner.
     */
    function setTokenMetadata(
        string memory name_,
        string memory description_,
        string memory imageUrl_
    ) public onlyOwner {
        _tokenName = name_;
        _tokenDescription = description_;
        _tokenImage = imageUrl_;
    }
}