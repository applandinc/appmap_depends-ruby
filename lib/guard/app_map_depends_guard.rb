require 'guard'
require 'guard/compat/plugin'

module ::Guard
  class AppMapDependsGuard < Plugin
    def run_on_modifications(paths)
      compute_diff(paths)
    end
    def run_on_additions(paths)
      compute_diff(paths)
    end
    def run_on_removals(paths)
      compute_diff(paths)
    end

    # Touch all test files that depend on 'paths'
    def compute_diff(paths)
      require 'appmap_depends'
      depends = AppMap::Depends::AppMapJSDepends.new
      files = depends.depends(paths)
      files.each do |file|
        FileUtils.touch file, nocreate: true
      end
    end
  end
end