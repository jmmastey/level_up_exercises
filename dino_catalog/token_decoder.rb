# A mixin whereby a class can select one instance from a predefined list that corresponds with
# some input token; and an instance can be queried for its correspondence to input tokens.
# Used to implement keywords from the data files that translate to dinosaur attributes.
module TokenDecoder

  # isValidToken?
  #
  # Parameters
  #   prefix (string) - word to test as potential prefix of standard
  #   standard (string) - word to test whether prefix is leading match of
  # Returns: True iff "prefix" is a proper prefix of "standard" of more than 3 chars
  # Implements very simple method to equate input tokens to those recognized as identifying
  # objects descriptive of dinosaurs during input source interpretation
  def isValidToken?(prefix)

    (prefix.length >= 3) && (getStandard().slice(0, prefix.length).casecmp(prefix) == 0)
  end

  # getStandard (abstract)
  #
  # Returns: (string) A token that represents this object against which other tokens are matched
  # Must be overridden in comprising classes to provide a token to match
  def getStandard

    raise NotImplementedError
  end

  # Place these in a module that can be used (below) to extend a comprising class, thereby
  # implementing static method mixin that is not a native ruby behavior
  module StaticMethods

    # createByToken (primary class interface method)
    #
    # Parameters
    #   token (string) - A token word to be used to select an instance of comprising class to create
    # Returns: (TokenFactory) An instance of the comprising class, or LAST OBJECT BY DEFAULT
    # Called on comprising class to select an instance for the input token
    def createByToken(token)

      stdobjs = getStandardObjects

      # Reduce the list of standard instances to find one that claims the token; but only one!
      return stdobjs.inject(nil) { |last_match, stdobj|

        if stdobj.isValidToken?(token) 

          return stdobjs.last if last_match     # No matches when more than one matches
          stdobj
        else

          last_match
        end
      } || stdobjs.last    # If no match, return last one
    end

    # getStandardObjects (class, abstract)
    #
    # Returns: Predefined list of comprising class instances that may be selected by tokens.
    # with the LAST object being DEFAULT when no other claims a token match
    def getStandardObjects
      raise NotImplementedError
    end
  end


  # Because ruby does not mixin class methods, it has to be done explicitly. The above module is full
  # of the methods meant to be mixed in as class methods.
  def self.included(comprising_class)
  
    comprising_class.extend StaticMethods
  end
end  # module TokenDecoder

