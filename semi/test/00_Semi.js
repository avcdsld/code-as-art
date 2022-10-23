const { deployments, getNamedAccounts } = require('hardhat');
const { fixture, get, execute, read, deploy } = deployments;

describe('Semi', () => {
  it('mint', async function () {
    const { deployer } = await getNamedAccounts();

    await fixture(['Semi']);
    const Semi = await get('Semi');
    console.log(Semi.address);

    for (let i = 0; i < 30; i++) {
      await execute('Semi', { from: deployer }, 'mint', deployer);
    }

    const tokenURI = await read('Semi', 'tokenURI', 1);
    console.log(tokenURI);

    // add new renderer

    const newRendererContract = await deploy('Renderer', {
      from: deployer,
      log: true,
    });
    await execute(
      'Renderer',
      { from: deployer },
      'setNftContract',
      Semi.address,
    );
    await execute('Semi', { from: deployer }, 'updateRenderer', newRendererContract.address);

    const rendererVersion = await read('Semi', 'rendererVersion');
    console.log('rendererVersion', rendererVersion.toString());

    const newTokenURI1 = await read('Semi', 'tokenURI', 1);
    console.log('newTokenURI1', newTokenURI1);
    const newTokenURI2 = await read('Semi', 'tokenURI', 2);
    console.log('newTokenURI2', newTokenURI2);

    await execute('Semi', { from: deployer }, 'setRendererVersion', 1, 1);
    const desiredRendererVersion1 = await read('Semi', 'desiredRendererVersions', 1);
    console.log('desiredRendererVersion1', desiredRendererVersion1.toString());
    const desiredRendererVersion2 = await read('Semi', 'desiredRendererVersions', 2);
    console.log('desiredRendererVersion2', desiredRendererVersion2.toString());
  });
});
