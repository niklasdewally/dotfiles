-- my rust-analyzer settings
return {
  settings = {
    ['rust-analyzer'] = {
      cargo = {
        -- make rust-analyzer use its own build cache
        targetDir = true
      }
    }
  }
}
