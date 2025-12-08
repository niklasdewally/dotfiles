return {
  settings = {
    pylsp = {
      plugins = {
        rope_completion = {
          enabled = true
        },

        rope_autoimport = {
          enabled = true
        },

        -- use ruff for linting and formatting
        autopep8 = {
          enabled = false
        },

        flake8 = {
          enabled = false
        },

        pycodestyle = {
          enabled = false
        },

        pydocstyle = {
          enabled = false
        },

        yapf = {
          enabled = false
        }
      }
    }
  }
}
