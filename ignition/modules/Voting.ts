import { buildModule } from "@nomicfoundation/hardhat-ignition/modules";


const ProposalNames =["solomon","simon","jude"];

const VoteModule = buildModule("VoteModule", (m) => {
  const voting = m.contract("VotingSystem",[ProposalNames]);

  return { voting };
});

export default VoteModule;
