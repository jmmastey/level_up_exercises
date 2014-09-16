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


## DRY it Up

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

## Hooks & Tags

```
before(:each)     # before each example runs
before(:all)      # once before all examples

after(:each)      # after each example runs
after(:all)       # once after all examples have run

```


## Mocks & Stubs

We want to test "decapitate" but don't want it to be executed

Stub - replacing method w/ code that returns a specified result

Mock - a stub w/ an expectation attached to it, an expectation that the method gets called

Zombie 

```
decapitate
```

weapon

``` 
def slice(*args)
	return nil
end
```

"Stub out" or "blank out" that slice method: `zombie.weapon.stub(:slice)`



```
describe Zombie do
	let(:zombie) { Zombie.create }
	
	context "#decapitate" do                              # method we're testing
	
		it "calls weapon.slice" do
			zombie.weapon.should_receive(:slice)          # mock
			zombie.decapitate
		end
		
		it "sets status to dead again"
			zombie.weapon.stub(:slice)
			zombie.decapitate
			zombie.status.should == "dead again"          # an expectation
		end
		
	end
end
	

```


Stub out slice method and set an expectation that the method is going to get called inside of our example `zombie.weapon.should_receive(:slice)`
then `decapitate` will try to call slice

Example method to test:

```
def geolocate
	Zoogle.graveyard_locator(self.graveyard)
	"#{loc[:latitude]}, #{loc[:longitude]}"
end
```

stubs the method & expectation with correct **param** and **return value**

```
it "calls Zoogle.graveyard_locator" do
	Zoogle.should_receive(:graveyard_locator).with(zombie.graveyard)
		.and_return({latitude: 2, longitude: 3} )
	zombie.geolocate   # fullfill expectation
end
```

Stub & return

```
it "returns properly formatted lat, long" do
	Zoogle.stub(:graveyard_locator).with(zombie.graveyard)
		.and_return({latitude: 2, longitude: 3} )
	zombie.geolocate.should == "2, 3" 
end
```

More complex (return lat, long)

```
def geolocate_with_object
	loc = Zoogle.graveyard_locator(self.graveyard)
	"#{loc[:latitude]}, #{loc[:longitude]}"
end
```


Create a stub/double

```
it "returns properly formatted lat, long" do
	loc = stub(latitude:2, longitude: 3)
	Zoogle.stub(:graveyard_locator).returns(loc)
	zombie.geolocate_with_object.should == "2, 3" 
end
```



Another example:

```
describe Tweet do
  context 'after create' do
    let(:zombie) { Zombie.create(email: 'anything@example.org') }
    let(:tweet) { zombie.tweets.new(message: 'Arrrrgggghhhh') }
    let(:mail) { stub(:mail, deliver: true) }

    it 'calls "tweet" on the ZombieMailer' do
      ZombieMailer.should_receive(:tweet).with(zombie, tweet).and_return(mail)
      tweet.save
    end

    it 'calls "deliver" on the mail object' do
      ZombieMailer.stub(tweet: mail)
      mail.should_receive(:deliver).and_return(true) 
      tweet.save
    end
  end
end
 
 ```

```
it 'calls "tweet" on the ZombieMailer as many times as there are zombies' do
    Zombie.stub(all: [stub, stub, stub])
    ZombieMailer.should_receive(:tweet).exactly(3).times.and_return(mail)
    tweet.save
end
```
