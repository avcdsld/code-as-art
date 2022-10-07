const func = async (hre) => {
  const { deployments, getNamedAccounts } = hre;
  const { deploy } = deployments;
  const { deployer } = await getNamedAccounts();
  await deploy("Protein", {
    from: deployer,
    log: true,
  });
};

module.exports = func;
module.exports.tags = ["Protein"];
