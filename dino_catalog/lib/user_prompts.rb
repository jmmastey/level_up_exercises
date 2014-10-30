module UserPrompts

  USER_SEARCH_PROMPT = <<-HEREDOC.strip_heredoc

      What would you like to do?\n
      You can enter a phrase that includes the keywords you want to filter the dinosaur catalog by.\n
      For example:\n
        Carnivores Big Triassic Bipeds\n
      Which will return all dinosaurs that meet the four criteria.\n
      Otherwise, to exit this program, enter 'quit'.\n
      HEREDOC

    USER_PROCESSING_PROMPT = <<-HEREDOC.strip_heredoc

      You may perform the following action on the search results\n
        Enter 'Print' to list the dinosaurs that met your search criteria.\n
        Enter the dinosaur's name to list information on an individual dinosaur.\n
        Enter 'json' to export the search results as a JSON file.\n
        Enter 'Search' to perform another search.\n
      Otherwise, to exit this program, enter 'quit'.\n
      HEREDOC

end
