pragma ton-solidity >= 0.35.0;
pragma AbiHeader expire;

contract Multiplication {

	// State variable storing the multiplication of arguments that were passed to function 'multip',
	uint public mult = 1;

	constructor() public {
		// check that contract's public key is set
		require(tvm.pubkey() != 0, 101);
		// Check that message has signature (msg.pubkey() is not zero) and message is signed with the owner's private key
		require(msg.pubkey() == tvm.pubkey(), 102);
		tvm.accept();
	}

	// Modifier that allows to accept some external messages
	modifier checkOwnerAndAccept {
		// Check that message was signed with contracts key.
		require(msg.pubkey() == tvm.pubkey(), 102);
		tvm.accept();
		_;
	}

	// Function that multiplication its argument to the state variable.
	function multip(uint value) public checkOwnerAndAccept {
        require((value >= uint(1) && value <= uint(10)), 103);
		mult = mult * value;
	}
}