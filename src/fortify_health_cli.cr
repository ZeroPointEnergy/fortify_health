require "../config/**"
require "cli"
require "./fortify_health_cli/importer/base"
require "./fortify_health_cli/importer/swiss_food_composition_database"


class FortifyHealthCli < Cli::Supercommand

  class Help
    header "Various helper and maintenance commands for Fortify Heatlh"
  end

  class Options
    help
  end

  class Import < Cli::Command
    class Options
      string "--importer", desc: "Select importer", required: true
      string "--file", desc: "file with data to import"
      string "--version", desc: "data version"
    end

    def run
      FortifyHelpCli::Importer::SFCD.import(args.file, args.version)
    end
  end

end

begin
  FortifyHealthCli.run(ARGV)
rescue ex
  puts ex.class
  puts ex.message
  puts ex.backtrace.inspect
  #FortifyHealthCli.run(%w(--help))
end
