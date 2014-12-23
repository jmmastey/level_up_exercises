namespace :orders do
  desc "Loads orders created since the last API call."
  task :update do
    items = Item.all
    items.each_with_index do |item, index|
      puts "#{index + 1}/#{items.count}: " \
           "Retrieving orders for #{item.name} (##{item.in_game_id})."
      Order.update_from_api(item, true)
    end
  end
end
