pragma solidity >=0.7.0 <0.9.0;

interface  ICaller{

    function drip(address token) external;
    function transfer(address _to, uint256 _value) external payable;

}

contract Minter {

    address target = 0x1ec1E49a7591f79280AF043DE07228CFCd68e0AC;

    function execDrip(address _address) external {
        ICaller(target).drip(_address);
        }

    function transfer(address _tokenAddress, address _to, uint256 _value) external {
        ICaller(_tokenAddress).transfer(_to, _value);
    }

}

contract MinterFactory {

    Minter[] private minterArray;

    function deployAndDrip(uint _amount, address _tokenAddress) public {
        for(uint i = 0; i < _amount; i++) {
            Minter minter = new Minter();
            minterArray.push(minter);
            minter.execDrip(_tokenAddress);
            }
    }

    function transfer(uint _offset, uint _amount, address _tokenAddress, address _to, uint256 _value) public {
        for(uint i = _offset; i < _amount; i++) {
            Minter(address(minterArray[i])).transfer(_tokenAddress, _to, _value);
        }
    }

}
