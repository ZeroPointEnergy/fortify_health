#
# Importer for the Swiss Food Composition Database
#
require "csv"

class FortifyHelpCli::Importer::SFCD < FortifyHelpCli::Importer::Base

  # Row numbers if the csv files
  ID = 0
  NAME = 3
  CALORIES = 21
  AMOUNT = 23
  PROTEIN = 26
  CARBOHYDRATES = 41
  FAT = 61

  def self.import(csv_file : String, version : String)
    set_product_source(
      name: "Swiss Food Composition Database",
      url: "http://naehrwertdaten.ch",
      notes: "Version #{version}"
    )

    data = CSV.parse(File.read(csv_file))
    data[3..-1].each do |row|
      begin
        next if row[ID].empty?
        new(
          external_id: row[ID],
          name: row[NAME],
          amount: 100.to_f,
          unit: unit(row[AMOUNT]),
          calories: row[CALORIES].to_f,
          protein: row[PROTEIN].to_f,
          carbohydrates: row[CARBOHYDRATES].to_f,
          fat: row[FAT].to_f
        ).import
      rescue IndexError
      rescue ex
        puts "Error while parsing a row (#{ex.class}) : #{ex.message}"
        puts row.inspect
      end
    end
  end

  private def self.unit(amount_text)
    case (amount_text || "")
    when /100g/ then "g"
    when /100ml/ then "ml"
    else
      "?"
    end
  end
end
