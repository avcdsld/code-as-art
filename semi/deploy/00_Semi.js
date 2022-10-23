const func = async (hre) => {
  const { deployments, getNamedAccounts } = hre;
  const { deploy, execute } = deployments;
  const { deployer } = await getNamedAccounts();
  const rendererContract = await deploy('Renderer', {
    from: deployer,
    log: true,
  });
  const nftContract = await deploy('Semi', {
    from: deployer,
    args: [rendererContract.address],
    log: true,
  });

  const txReceipt = await execute(
    'Renderer',
    { from: deployer },
    'setNftContract',
    nftContract.address,
  );
  console.log(txReceipt);
};

module.exports = func;
module.exports.tags = ['Renderer', 'Semi'];
