-- lua/plugins/java.lua
return {
  'mfussenegger/nvim-jdtls',
  ft = { 'java' },
  config = function()
    local jdtls = require('jdtls')

    local home = vim.env.HOME
    local jdtls_path = vim.fn.stdpath('data') .. '/mason/packages/jdtls'

    local launcher_path =
      vim.fn.glob(jdtls_path .. '/plugins/org.eclipse.equinox.launcher_*.jar')
    if launcher_path == '' then
      launcher_path =
        vim.fn.glob(jdtls_path .. '/plugins/org.eclipse.equinox.launcher_*.jar', 1, 1)[1]
    end

    local config = 'linux'
    local work_dir = home .. '/.jdtls-workspace'

    local root_markers = { '.git', 'gradlew', 'mvnw', 'pom.xml', 'build.gradle' }
    local root_dir = require('jdtls.setup').find_root(root_markers)
    if root_dir == '' then
      vim.notify('Could not find Java project root', vim.log.levels.ERROR)
      return
    end

    local project_name = vim.fn.fnamemodify(vim.fn.getcwd(), ':p:h:t')
    local workspace_dir = work_dir .. '/' .. project_name

    local config = {
      cmd = {
        'java',
        '-Declipse.application=org.eclipse.jdt.ls.core.id1',
        '-Dosgi.bundles.defaultStartLevel=4',
        '-Declipse.product=org.eclipse.jdt.ls.core.product',
        '-Dlog.protocol=true',
        '-Dlog.level=ALL',
        '-Xms1g',
        '--add-modules=ALL-SYSTEM',
        '--add-opens',
        'java.base/java.util=ALL-UNNAMED',
        '--add-opens',
        'java.base/java.lang=ALL-UNNAMED',
        '-jar',
        launcher_path,
        '-configuration',
        jdtls_path .. '/config_' .. config,
        '-data',
        workspace_dir,
      },
      root_dir = root_dir,
      settings = {
        java = {
          eclipse = { downloadSources = true },
          maven = { downloadSources = true },
          configuration = { updateBuildConfiguration = 'interactive' },
        },
      },
    }

    jdtls.start_or_attach(config)
  end,
}
