pragma solidity ^0.4.2;

/** @title myConsents Smart Contract for storing user consents in a blockchain transaction log structure.
 *  @author WJK
 */
contract MyConsents {
    event LogGiveConsent(address indexed _personalDataSubject, address indexed _dataController, bytes32 indexed _consentId, bytes32 _personalDataSetId, bytes32 _personalDataHash);
    event LogWithdrawConsent(address indexed _personalDataSubject, bytes32 indexed _giveConsentTxHash);

    /** Represents owner of SC */
    address owner;

    /** @dev Function executed at initialization. Sets the owner of the SC. */
    function MyConsents() {
        owner = msg.sender;
    }

    /** @dev Function to recover the funds from the SC */
    function kill() public {
        if (msg.sender == owner)
            suicide(owner);
    }

    /** @dev Logs an consent giving event to block chain.
     * _dataController - ethereum account address of Data controller (Organization) involved in personal data processing,
     * _consentId - identifier of Consent type. Represents bytes32 value referring to consent catalogue,
     * _personalDataSetId - identifier of personal data attributes set.
     * _personalDataHash - hash of personal data atributes values related to set of attributes identified by _personalDataSetId,*/
    function giveConsent(
        address _dataController,
        bytes32 _consentId,
        bytes32 _personalDataSetId,
        bytes32 _personalDataHash
    ) public {
        LogGiveConsent(msg.sender, _dataController, _consentId, _personalDataSetId, _personalDataHash);
    }

    /** Logs a consent withdrawing event to block chain.
     *  _giveConsentTxHash - transaction hash referring to transaction where consent giving event was logged.*/
    function withdrawConsent(bytes32 _giveConsentTxHash) public {
        LogWithdrawConsent(msg.sender, _giveConsentTxHash);
    }
}
