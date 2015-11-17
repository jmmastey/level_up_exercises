## PeteMail

Hot off his last two victories, Peteshow and Petelab, our favorite protagonist is looking for more industries to revolutionize. Frustrated with the existing level of vim keybinding support in his mail client, it's time to introduce Pmail. Unfortunately, Pete's dotfiles are acting up again, so you're going to need to write the UI while he fiddles with them.

## Requirements

Pete needs the HTML, CSS and Javascript for a basic Gmail lookalike. You don't have to use any fancy precompilers like Coffee or HAML, but props if you feel like doing it anyway. Take a look at the Gmail interface and clone away. If you've never seen the Gmail interface... I don't believe you. Just do it.

Functionality:
* You don't need a backend for this system, a straightforward HTML mockup will do the trick. Pete's messing with Ember and who knows when that's going to be done, so all your backend would get thrown away anyway.
* A basic inbox layout, with links to folders etc in the sidebar. Don't worry about making them functional yet, but give them dapper looking hover states. Business users love that shit.
* Add a dropdown menu for the user's profile that opens on hover and allows them to Log out, view their settings, etc.
* Your content, structure and behavior should be properly separated. 
* If you can figure it out, add keyboard commands to navigate up and down selecting the "current" email row.
as