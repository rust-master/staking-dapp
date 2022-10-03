pragma solidity ^0.8.0;

import "./ERC20/IERC20.sol";

contract Staking {
  address public owner;

  uint public currentTokenId = 1;

  struct Token {
    uint tokenId;
    string name;
    string symbol;
    address tokenAddress;
    uint usdPrice;
    uint ethPrice;
    uint apy;
  }

  struct Position {
    uint positionId;
    address walletAddress;
    string name;
    string symbol;
    uint createdDate;
    uint apy;
    uint tokenQuantity;
    uint usdValue;
    uint ethValue;
    bool open;
  }

  uint public ethUsdPrice;

  string[] public tokenSymbols;
  mapping(string => Token) public tokens;

  uint public currentPositionId = 1;

  mapping(uint => Position) public positions;

  mapping(address => uint[]) public positionIdsByAddress;

  mapping(string => uint) public stakedTokens;


  constructor(uint currentEthPrice) payable {
    ethUsdPrice = currentEthPrice;
    owner = msg.sender;
  }

  function addToken(
    string calldata name,
    string calldata symbol,
    address tokenAddress,
    uint usdPrice,
    uint apy
  ) external onlyOwner {
    tokenSymbols.push(symbol);

    tokens[symbol] = Token(
        currentTokenId,
        name,
        symbol,
        tokenAddress,
        usdPrice,
        usdPrice / ethUsdPrice,
        apy
    );

    currentTokenId += 1;
  }

  function transferOwnership(address newOwner) public  {
        if (newOwner != address(0)) {
            owner = newOwner;
        }
    }
    //stake tokens function

    function stakeTokens(uint256 _amount) public {
        //must be more than 0
        require(_amount > 0, "amount cannot be 0");

       

        //User adding test tokens
        rISINGBIRD.transferFrom(msg.sender, address(this), _amount);
        totalStaked = totalStaked + _amount;

        //updating staking balance for user by mapping
        stakingBalance[msg.sender] = stakingBalance[msg.sender] + _amount;
        staking_start_time[msg.sender] = block.timestamp;


        //checking if user staked before or not, if NOT staked adding to array of stakers
        if (!hasStaked[msg.sender]) {
            stakers.push(msg.sender);
        }

        //updating staking status
        
        hasStaked[msg.sender] = true;
        isStakingAtm[msg.sender] = true;
    }

    //unstake tokens function

    function unstakeTokens() public {
        //get staking balance for user

        uint256 balance = stakingBalance[msg.sender];

        //amount should be more than 0
        require(balance > 0, "amount has to be more than 0");

        //transfer staked tokens back to user
        rISINGBIRD.transfer(msg.sender, balance);
        totalStaked = totalStaked - balance;

        //reseting users staking balance
        stakingBalance[msg.sender] = 0;

        //updating staking status
        isStakingAtm[msg.sender] = false;
    }

    // different APY Pool
    function customStaking(uint256 _amount) public {
        require(_amount > 0, "amount cannot be 0");
        rISINGBIRD.transferFrom(msg.sender, address(this), _amount);
        customTotalStaked = customTotalStaked + _amount;
        customStakingBalance[msg.sender] =
            customStakingBalance[msg.sender] +
            _amount;

        if (!customHasStaked[msg.sender]) {
            customStakers.push(msg.sender);
        }
        customHasStaked[msg.sender] = true;
        customIsStakingAtm[msg.sender] = true;
    }

    function customUnstake() public {
        uint256 balance = customStakingBalance[msg.sender];
        require(balance > 0, "amount has to be more than 0");
        rISINGBIRD.transfer(msg.sender, balance);
        customTotalStaked = customTotalStaked - balance;
        customStakingBalance[msg.sender] = 0;
        customIsStakingAtm[msg.sender] = false;
    }

    //airdropp tokens
    function redistributeRewards() public {

         require(block.timestamp >=  staking_start_time[msg.sender] + 2678400 , " you can not  get reward before 30 days");
       
            uint256 balance = stakingBalance[msg.sender] * 5 /100; 
            balance = stakingBalance[msg.sender] + balance;
            

            if (balance > 0) {
                rISINGBIRD.transfer(msg.sender, balance);
            
            }
        
    }

   
    //change APY value for custom staking
    function changeAPY(uint256 _value) public {
        //only owner can issue airdrop
        require(msg.sender == owner, "Only contract creator can change APY");
        require(
            _value > 0,
            "APY value has to be more than 0, try 100 for (0.166% daily) instead"
        );
        customAPY = _value;
    }

}