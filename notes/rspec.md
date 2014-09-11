#Rspec


## Setup 
`$ gem install rspec`

`$ rspec --init` from within directory

`$ rails g rspec:install`

## Location
spec/lib/<name>_spec.rb


## Run

`$ rspec ` for all tests

`$ rspec /lib/zombie_spec.rb`

Options

```
--color
--format documentation
```


## Write

```
require 'spec_helper'

describe Zombie do
  it "is named Colleen"
  	zombie = Zombie.new
  	zombie.name.should == 'Colleen'
  end
  
  it "has no brains" do
    zombie = Zombie.new
    zombie.brains.should < 1
  end
  
  it "is not alive" do
  	zombie.alive.should be_false
  end
end
```

### Configuration & Matchers
Setup as usual...

```
require 'spec_helper'

describe Zombie do
  # it blocks
end
```

#### Predicate matcher

```
  it "is invalid without a name"
  	zombie = Zombie.new
  	zombie.should_not be_valid                 # calls .valid?
  end
```

#### Have matcher

`have(n)`,`have_at_least(n)`, `have_at_most(n)`

```  
  it "starts w/ two weapons" do
    zombie = Zombie.new(name: "Colleen")
    zombie.should have(2).weapons             # zombie.weapons.count.should == 2 
  end
```


#### Change matcher

`by(n)`, `from(n)`, `to(n)`

```  
  it "changes the number of Zombies" do
  	zombie = Zombie.new(name: "Colleen")
  	expect { zombie.save }.to change { Zombie.count }.by(1)
  end
```

Additional matchers

```
@zombie.should respont_to(hungry?)
@width.should be_within(.1).of(33.3)
```


### DRY it Up

```
it { should respond_to(:name) }
```

"subject" is an instance of the class

```
it { subject.name.should == "Colleen" }
its(:name) { should == "Colleen" } 
its(:weapons) { should include(weapon) }
its(:brain) { should be_nil }
```

Let

```
let(:zombie) { Zombie.create }
subject { zombie }

its(:name) { should be_nil? }

it { should be_craving_brains} 
```




































