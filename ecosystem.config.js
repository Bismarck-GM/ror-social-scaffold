module.exports = {
  apps : [{
    script: 'rails server -b 0.0.0.0',
    exec_mode : 'fork_mode',
  }],

  deploy : {
    production : {
    }
  }
};
