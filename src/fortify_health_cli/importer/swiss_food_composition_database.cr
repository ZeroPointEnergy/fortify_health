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
    data[2..-1].each do |row|
      new(
        external_id: row[ID],
        name: row[NAME],
        amount: 100.to_i32,
        unit: unit(row[AMOUNT]),
        calories: row[CALORIES].to_i32,
        protein: row[PROTEIN].to_i32,
        carbohydrates: row[CARBOHYDRATES].to_i32,
        fat: row[FAT].to_i32
      ).import
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
