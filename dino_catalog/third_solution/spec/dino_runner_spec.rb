require_relative "../dino_runner"

describe DinoRunner do

  test_path = File.expand_path("..", __FILE__) + "/test"

  let(:subject_default) { DinoRunner.new([]) }
  let(:subject_test) { DinoRunner.new([test_path])}

  describe "greeting display" do
    it "displays some greeting text" do
      expect{subject_test.greeting_display}.to output(/Welcome to Di-Facto, your presumed source for prehistoric points of interest/).to_stdout
    end
  end


  describe "run" do
    before do
      $stdin = StringIO.new("-e\n")
    end
    after do
      $stdin = STDIN
    end

    it "displays greeting text at startup" do
      expect{
        subject_test.run
      }.to output(
        /Welcome to Di-Facto, your presumed source for prehistoric points of interest/
      ).to_stdout
      
    end

    it "displays help text at startup" do
      expect{
        subject_test.run
      }.to output(
        /-h or help: access this help menue\n-e or exit: exit the program\n-l or list: view a list of all dinos\n-b or big: view a list of dino >= 4000lb\n-c or carnivorus: view a list of all non-plant eating dinosaurs\n-2 or biped: view a list of all bipedal dinosaurs\n-p or period <period>: view a list of dinosaurs from the <period> period\n-f or filter <big | biped | carnivorus or their abbreviations>: view a listed filtered by all included criteria\n-s or search category:<term> category:<term>... : view a list of dinos filtered by search criteria/
      ).to_stdout
    end

    it "displays list of all dinos shorthand" do
      expect{
        subject = subject_test
        subject.command = ["-l"]
        subject.run
      }.to output(
        /name: Albertosaurus, weight: 2000, diet: Carnivore, locomotion: Biped, period: Late Cretaceous, continent: North America, description: Like a T-Rex but smaller.\n\nname: Albertonykus, diet: Insectivore, locomotion: Biped, period: Early Cretaceous, continent: North America, description: Earliest known Alvarezsaurid.\n\nname: Baryonyx, weight: 6000, diet: Piscivore, locomotion: Biped, period: Early Cretaceous, continent: Europe, description: One of the only known dinosaurs with a fish-only diet.\n\nname: Deinonychus, weight: 150, diet: Carnivore, locomotion: Biped, period: Early Cretaceous, continent: North America\n\nname: Diplocaulus, diet: Carnivore, locomotion: Quadruped, period: Late Permian, continent: North America, description: They actually had fins on the side of their body.\n\nname: Abrictosaurus, weight: 100, diet: herbivore, locomotion: Biped, period: Jurassic\n\nname: Afrovenator, diet: carnivore, locomotion: Biped, period: Jurassic\n\nname: Carcharodontosaurus, weight: 3000, diet: carnivore, locomotion: Biped, period: Albian\n\nname: Paralititan, weight: 120000, diet: herbivore, locomotion: Quadruped, period: Cretaceous\n\nname: Suchomimus, weight: 10400, diet: carnivore, locomotion: Biped, period: Cretaceous\n\n/
      ).to_stdout
    end

    it "displays list of all dinos longhand" do
      expect{
        subject = subject_test
        subject.command = ["list"]
        subject.run
      }.to output(
        /name: Albertosaurus, weight: 2000, diet: Carnivore, locomotion: Biped, period: Late Cretaceous, continent: North America, description: Like a T-Rex but smaller.\n\nname: Albertonykus, diet: Insectivore, locomotion: Biped, period: Early Cretaceous, continent: North America, description: Earliest known Alvarezsaurid.\n\nname: Baryonyx, weight: 6000, diet: Piscivore, locomotion: Biped, period: Early Cretaceous, continent: Europe, description: One of the only known dinosaurs with a fish-only diet.\n\nname: Deinonychus, weight: 150, diet: Carnivore, locomotion: Biped, period: Early Cretaceous, continent: North America\n\nname: Diplocaulus, diet: Carnivore, locomotion: Quadruped, period: Late Permian, continent: North America, description: They actually had fins on the side of their body.\n\nname: Abrictosaurus, weight: 100, diet: herbivore, locomotion: Biped, period: Jurassic\n\nname: Afrovenator, diet: carnivore, locomotion: Biped, period: Jurassic\n\nname: Carcharodontosaurus, weight: 3000, diet: carnivore, locomotion: Biped, period: Albian\n\nname: Paralititan, weight: 120000, diet: herbivore, locomotion: Quadruped, period: Cretaceous\n\nname: Suchomimus, weight: 10400, diet: carnivore, locomotion: Biped, period: Cretaceous\n\n/
      ).to_stdout
    end

    it "displays big dinos shorthand" do
      expect{
        subject = subject_test
        subject.command = ["-b"]
        subject.run
      }.to output(
        /name: Baryonyx, weight: 6000, diet: Piscivore, locomotion: Biped, period: Early Cretaceous, continent: Europe, description: One of the only known dinosaurs with a fish-only diet.\n\nname: Paralititan, weight: 120000, diet: herbivore, locomotion: Quadruped, period: Cretaceous\n\nname: Suchomimus, weight: 10400, diet: carnivore, locomotion: Biped, period: Cretaceous\n\n/
      ).to_stdout
    end

    it "displays big dinos long hand" do
      expect{
        subject = subject_test
        subject.command = ["big"]
        subject.run
      }.to output(
        /name: Baryonyx, weight: 6000, diet: Piscivore, locomotion: Biped, period: Early Cretaceous, continent: Europe, description: One of the only known dinosaurs with a fish-only diet.\n\nname: Paralititan, weight: 120000, diet: herbivore, locomotion: Quadruped, period: Cretaceous\n\nname: Suchomimus, weight: 10400, diet: carnivore, locomotion: Biped, period: Cretaceous\n\n/
      ).to_stdout
    end

    it "displays small dinos shorthand" do
      expect{
        subject = subject_test
        subject.command = ["-m"]
        subject.run
      }.to output(
        /name: Albertosaurus, weight: 2000, diet: Carnivore, locomotion: Biped, period: Late Cretaceous, continent: North America, description: Like a T-Rex but smaller.\n\nname: Albertonykus, diet: Insectivore, locomotion: Biped, period: Early Cretaceous, continent: North America, description: Earliest known Alvarezsaurid.\n\nname: Deinonychus, weight: 150, diet: Carnivore, locomotion: Biped, period: Early Cretaceous, continent: North America\n\nname: Diplocaulus, diet: Carnivore, locomotion: Quadruped, period: Late Permian, continent: North America, description: They actually had fins on the side of their body.\n\nname: Abrictosaurus, weight: 100, diet: herbivore, locomotion: Biped, period: Jurassic\n\nname: Afrovenator, diet: carnivore, locomotion: Biped, period: Jurassic\n\nname: Carcharodontosaurus, weight: 3000, diet: carnivore, locomotion: Biped, period: Albian\n\n/
      ).to_stdout
    end

    it "displays small dinos longhand" do
      expect{
        subject = subject_test
        subject.command = ["small"]
        subject.run
      }.to output(
        /name: Albertosaurus, weight: 2000, diet: Carnivore, locomotion: Biped, period: Late Cretaceous, continent: North America, description: Like a T-Rex but smaller.\n\nname: Albertonykus, diet: Insectivore, locomotion: Biped, period: Early Cretaceous, continent: North America, description: Earliest known Alvarezsaurid.\n\nname: Deinonychus, weight: 150, diet: Carnivore, locomotion: Biped, period: Early Cretaceous, continent: North America\n\nname: Diplocaulus, diet: Carnivore, locomotion: Quadruped, period: Late Permian, continent: North America, description: They actually had fins on the side of their body.\n\nname: Abrictosaurus, weight: 100, diet: herbivore, locomotion: Biped, period: Jurassic\n\nname: Afrovenator, diet: carnivore, locomotion: Biped, period: Jurassic\n\nname: Carcharodontosaurus, weight: 3000, diet: carnivore, locomotion: Biped, period: Albian\n\n/
      ).to_stdout
    end

    it "displays carnivorus dinos longhand" do
      expect{
        subject = subject_test
        subject.command = ["-c"]
        subject.run
      }.to output(
        /name: Albertosaurus, weight: 2000, diet: Carnivore, locomotion: Biped, period: Late Cretaceous, continent: North America, description: Like a T-Rex but smaller.\n\nname: Albertonykus, diet: Insectivore, locomotion: Biped, period: Early Cretaceous, continent: North America, description: Earliest known Alvarezsaurid.\n\nname: Baryonyx, weight: 6000, diet: Piscivore, locomotion: Biped, period: Early Cretaceous, continent: Europe, description: One of the only known dinosaurs with a fish-only diet.\n\nname: Deinonychus, weight: 150, diet: Carnivore, locomotion: Biped, period: Early Cretaceous, continent: North America\n\nname: Diplocaulus, diet: Carnivore, locomotion: Quadruped, period: Late Permian, continent: North America, description: They actually had fins on the side of their body.\n\nname: Afrovenator, diet: carnivore, locomotion: Biped, period: Jurassic\n\nname: Carcharodontosaurus, weight: 3000, diet: carnivore, locomotion: Biped, period: Albian\n\nname: Suchomimus, weight: 10400, diet: carnivore, locomotion: Biped, period: Cretaceous\n\n/
      ).to_stdout
    end

    it "displays carnivorus dinos longhand" do
      expect{
        subject = subject_test
        subject.command = ["carnivorus"]
        subject.run
      }.to output(
        /name: Albertosaurus, weight: 2000, diet: Carnivore, locomotion: Biped, period: Late Cretaceous, continent: North America, description: Like a T-Rex but smaller.\n\nname: Albertonykus, diet: Insectivore, locomotion: Biped, period: Early Cretaceous, continent: North America, description: Earliest known Alvarezsaurid.\n\nname: Baryonyx, weight: 6000, diet: Piscivore, locomotion: Biped, period: Early Cretaceous, continent: Europe, description: One of the only known dinosaurs with a fish-only diet.\n\nname: Deinonychus, weight: 150, diet: Carnivore, locomotion: Biped, period: Early Cretaceous, continent: North America\n\nname: Diplocaulus, diet: Carnivore, locomotion: Quadruped, period: Late Permian, continent: North America, description: They actually had fins on the side of their body.\n\nname: Afrovenator, diet: carnivore, locomotion: Biped, period: Jurassic\n\nname: Carcharodontosaurus, weight: 3000, diet: carnivore, locomotion: Biped, period: Albian\n\nname: Suchomimus, weight: 10400, diet: carnivore, locomotion: Biped, period: Cretaceous\n\n/
      ).to_stdout
    end


    it "displays biped dinos shorthand" do
      expect{
        subject = subject_test
        subject.command = ["-2"]
        subject.run
      }.to output(
        /name: Albertosaurus, weight: 2000, diet: Carnivore, locomotion: Biped, period: Late Cretaceous, continent: North America, description: Like a T-Rex but smaller.\n\nname: Albertonykus, diet: Insectivore, locomotion: Biped, period: Early Cretaceous, continent: North America, description: Earliest known Alvarezsaurid.\n\nname: Baryonyx, weight: 6000, diet: Piscivore, locomotion: Biped, period: Early Cretaceous, continent: Europe, description: One of the only known dinosaurs with a fish-only diet.\n\nname: Deinonychus, weight: 150, diet: Carnivore, locomotion: Biped, period: Early Cretaceous, continent: North America\n\nname: Abrictosaurus, weight: 100, diet: herbivore, locomotion: Biped, period: Jurassic\n\nname: Afrovenator, diet: carnivore, locomotion: Biped, period: Jurassic\n\nname: Carcharodontosaurus, weight: 3000, diet: carnivore, locomotion: Biped, period: Albian\n\nname: Suchomimus, weight: 10400, diet: carnivore, locomotion: Biped, period: Cretaceous\n\n/
      ).to_stdout
    end
    it "displays biped dinos longhand" do
      expect{
        subject = subject_test
        subject.command = ["biped"]
        subject.run
      }.to output(
        /name: Albertosaurus, weight: 2000, diet: Carnivore, locomotion: Biped, period: Late Cretaceous, continent: North America, description: Like a T-Rex but smaller.\n\nname: Albertonykus, diet: Insectivore, locomotion: Biped, period: Early Cretaceous, continent: North America, description: Earliest known Alvarezsaurid.\n\nname: Baryonyx, weight: 6000, diet: Piscivore, locomotion: Biped, period: Early Cretaceous, continent: Europe, description: One of the only known dinosaurs with a fish-only diet.\n\nname: Deinonychus, weight: 150, diet: Carnivore, locomotion: Biped, period: Early Cretaceous, continent: North America\n\nname: Abrictosaurus, weight: 100, diet: herbivore, locomotion: Biped, period: Jurassic\n\nname: Afrovenator, diet: carnivore, locomotion: Biped, period: Jurassic\n\nname: Carcharodontosaurus, weight: 3000, diet: carnivore, locomotion: Biped, period: Albian\n\nname: Suchomimus, weight: 10400, diet: carnivore, locomotion: Biped, period: Cretaceous\n\n/
      ).to_stdout
    end


    it "displays period dinos shorthand" do
      expect{
        subject = subject_test
        subject.command = ["-p", "Cretaceous"]
        subject.run
      }.to output(
        /name: Albertosaurus, weight: 2000, diet: Carnivore, locomotion: Biped, period: Late Cretaceous, continent: North America, description: Like a T-Rex but smaller.\n\nname: Albertonykus, diet: Insectivore, locomotion: Biped, period: Early Cretaceous, continent: North America, description: Earliest known Alvarezsaurid.\n\nname: Baryonyx, weight: 6000, diet: Piscivore, locomotion: Biped, period: Early Cretaceous, continent: Europe, description: One of the only known dinosaurs with a fish-only diet.\n\nname: Deinonychus, weight: 150, diet: Carnivore, locomotion: Biped, period: Early Cretaceous, continent: North America\n\nname: Paralititan, weight: 120000, diet: herbivore, locomotion: Quadruped, period: Cretaceous\n\nname: Suchomimus, weight: 10400, diet: carnivore, locomotion: Biped, period: Cretaceous\n\n/
      ).to_stdout
    end
    it "displays period dinos longhand" do
      expect{
        subject = subject_test
        subject.command = ["period", "Cretaceous"]
        subject.run
      }.to output(
        /name: Albertosaurus, weight: 2000, diet: Carnivore, locomotion: Biped, period: Late Cretaceous, continent: North America, description: Like a T-Rex but smaller.\n\nname: Albertonykus, diet: Insectivore, locomotion: Biped, period: Early Cretaceous, continent: North America, description: Earliest known Alvarezsaurid.\n\nname: Baryonyx, weight: 6000, diet: Piscivore, locomotion: Biped, period: Early Cretaceous, continent: Europe, description: One of the only known dinosaurs with a fish-only diet.\n\nname: Deinonychus, weight: 150, diet: Carnivore, locomotion: Biped, period: Early Cretaceous, continent: North America\n\nname: Paralititan, weight: 120000, diet: herbivore, locomotion: Quadruped, period: Cretaceous\n\nname: Suchomimus, weight: 10400, diet: carnivore, locomotion: Biped, period: Cretaceous\n\n/
      ).to_stdout
    end


    it "displays filter dinos shorthand" do
      expect{
        subject = subject_test
        subject.command = ["-f", "-2", "-c"]
        subject.run
      }.to output(
        /name: Albertosaurus, weight: 2000, diet: Carnivore, locomotion: Biped, period: Late Cretaceous, continent: North America, description: Like a T-Rex but smaller.\n\nname: Albertonykus, diet: Insectivore, locomotion: Biped, period: Early Cretaceous, continent: North America, description: Earliest known Alvarezsaurid.\n\nname: Baryonyx, weight: 6000, diet: Piscivore, locomotion: Biped, period: Early Cretaceous, continent: Europe, description: One of the only known dinosaurs with a fish-only diet.\n\nname: Deinonychus, weight: 150, diet: Carnivore, locomotion: Biped, period: Early Cretaceous, continent: North America\n\nname: Afrovenator, diet: carnivore, locomotion: Biped, period: Jurassic\n\nname: Carcharodontosaurus, weight: 3000, diet: carnivore, locomotion: Biped, period: Albian\n\nname: Suchomimus, weight: 10400, diet: carnivore, locomotion: Biped, period: Cretaceous\n\n/
      ).to_stdout
    end
    it "displays filter dinos longhand" do
      expect{
        subject = subject_test
        subject.command = ["filter", "big", "small"]
        subject.run
      }.to output(
        /name: Baryonyx, weight: 6000, diet: Piscivore, locomotion: Biped, period: Early Cretaceous, continent: Europe, description: One of the only known dinosaurs with a fish-only diet.\n\nname: Paralititan, weight: 120000, diet: herbivore, locomotion: Quadruped, period: Cretaceous\n\nname: Suchomimus, weight: 10400, diet: carnivore, locomotion: Biped, period: Cretaceous\n\n/
      ).to_stdout
    end


    it "displays filtered dinos shorthand" do
      expect{
        subject = subject_test
        subject.command = ["-f", "-2", "-c"]
        subject.run
      }.to output(
        /name: Albertosaurus, weight: 2000, diet: Carnivore, locomotion: Biped, period: Late Cretaceous, continent: North America, description: Like a T-Rex but smaller.\n\nname: Albertonykus, diet: Insectivore, locomotion: Biped, period: Early Cretaceous, continent: North America, description: Earliest known Alvarezsaurid.\n\nname: Baryonyx, weight: 6000, diet: Piscivore, locomotion: Biped, period: Early Cretaceous, continent: Europe, description: One of the only known dinosaurs with a fish-only diet.\n\nname: Deinonychus, weight: 150, diet: Carnivore, locomotion: Biped, period: Early Cretaceous, continent: North America\n\nname: Afrovenator, diet: carnivore, locomotion: Biped, period: Jurassic\n\nname: Carcharodontosaurus, weight: 3000, diet: carnivore, locomotion: Biped, period: Albian\n\nname: Suchomimus, weight: 10400, diet: carnivore, locomotion: Biped, period: Cretaceous\n\n/
      ).to_stdout
    end
    it "displays filtered dinos longhand" do
      expect{
        subject = subject_test
        subject.command = ["filter", "big", "small"]
        subject.run
      }.to output(
        /name: Baryonyx, weight: 6000, diet: Piscivore, locomotion: Biped, period: Early Cretaceous, continent: Europe, description: One of the only known dinosaurs with a fish-only diet.\n\nname: Paralititan, weight: 120000, diet: herbivore, locomotion: Quadruped, period: Cretaceous\n\nname: Suchomimus, weight: 10400, diet: carnivore, locomotion: Biped, period: Cretaceous\n\n/
      ).to_stdout
    end

    it "displays searched dinos longhand" do
      expect{
        subject = subject_test
        subject.command = ["search", "continent:america", "diet:insectivore"]
        subject.run
      }.to output(
        /name: Albertonykus, diet: Insectivore, locomotion: Biped, period: Early Cretaceous, continent: North America, description: Earliest known Alvarezsaurid.\n\n/
      ).to_stdout      
    end
    it "displays searched dinos shorthand" do
      expect{
        subject = subject_test
        subject.command = ["-s", "continent:america", "diet:insectivore"]
        subject.run
      }.to output(
        /name: Albertonykus, diet: Insectivore, locomotion: Biped, period: Early Cretaceous, continent: North America, description: Earliest known Alvarezsaurid.\n\n/
      ).to_stdout        
    end
  end
end