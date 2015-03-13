require_relative "dino"

class DinoPrinter
  def initialize
    # Fixed column widths for formatting output
    @col_widths = {
      "NAME" => 22, "PERIOD" => 20, "CONTINENT" => 18, "DIET" => 16,
      "WEIGHT" => 8, "WALKING" => 12, "DESCRIPTION" => 40
    }
  end

  def display_dinos(params, catalog)
    if params.downcase == "all"
      display_table(catalog.dinos)
    else
      return printf "\nNo results to print\n" if catalog.results.empty?
      display_table(catalog.results)
    end
  end

  def display_results(results)
    printf "\nFound #{results.length} match(es): "
    matches = results.map { |dino| dino.name }
    puts matches.join(", ")
  end

  private

  def display_table(list)
    categories = get_categories(list)
    print_table_header(categories)

    verbose = list.length == 1 ? true : false

    list.each do |dino|
      print_dino(categories, dino, verbose)
    end
  end

  def get_categories(list)
    categories = []

    list.each do |dino|
#      categories << dino.keys
    end

    categories.flatten.uniq
    categories = ["NAME", "PERIOD", "CONTINENT", "DIET", "WEIGHT", "WALKING", "DESCRIPTION"]
  end

  def print_table_header(list)
    print_categories(list)
    print_separators(list)
  end

  def print_categories(list)
    puts ""
    list.each do |category|
      printf "%-#{@col_widths[category]}s", category
    end
    puts ""
  end

  def print_separators(list)
    list.each do |category|
      printf "%-#{@col_widths[category]}s", "-" * category.length
    end
    puts ""
  end

  def print_dino(categories, dino, verbose)
    categories.each do |category|
      print_entry(category, dino, verbose)
    end
    puts ""
  end

  def print_entry(category, dino, verbose)
    col_width = @col_widths[category]
    entry = dino.send(category.downcase)
    entry = truncate_entry(entry, col_width - 2) if !verbose

    printf "%-#{col_width}s", entry
  end

  def truncate_entry(entry, max_width)
    return entry if !entry || entry.length <= max_width

    truncated_entry = entry.slice(0..max_width - 3)
    truncated_entry << "..."
  end
end
