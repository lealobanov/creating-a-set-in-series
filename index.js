// Pass the repo name
const recipe = "creating-a-set-in-series";

//Generate paths of each code file to render
const contractPath = `${recipe}/cadence/contract.cdc`;
const transactionPath = `${recipe}/cadence/transaction.cdc`;

//Generate paths of each explanation file to render
const smartContractExplanationPath = `${recipe}/explanations/contract.txt`;
const transactionExplanationPath = `${recipe}/explanations/transaction.txt`;

export const creatingASetInSeries = {
  slug: recipe,
  title: "Creating a Set in Series",
  createdAt: new Date(2022, 3, 1),
  author: "Flow Blockchain",
  playgroundLink:
    "https://play.onflow.org/a7d190b6-e0f1-4acc-b34c-f37b39fbab33?type=tx&id=534c6a6a-e87a-4f10-b134-835deeff96ff&storage=none",
  excerpt:
    "Once you've implemented a series for your NFT, you now create Sets so that each NFT is part of a set in a series.",
  smartContractCode: contractPath,
  smartContractExplanation: smartContractExplanationPath,
  transactionCode: transactionPath,
  transactionExplanation: transactionExplanationPath,
  filters: {
    difficulty: "intermediate",
  },
};
