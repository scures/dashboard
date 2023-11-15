module.exports = {
  apps: [{
    name:   'UXUI-RANCHER-PM2',
    script: 'yarn',
    args:   'start',
    watch:  true,
    env:    { NODE_ENV: 'production' }
  }]
};
