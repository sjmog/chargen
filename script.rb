FIFTY_PERCENT_CHANCE = lambda { rand(1..10) >= 5 }

names = [
  "Pete"
]

class Secret
  SECRETS = [
    "An affair.",
    "An embarrassing incident.",
    "A nefarious research interest.",
    "Debt.",
    "Sexual fetishes.",
    "Something in their family history.",
    "A phobia.",
    "Something they bought.",
    "A drug or substance they take.",
    "An unrequited love."
  ]

  def initialize(text)
    @text = text
  end

  def empty?
    @text.empty?
  end

  def to_s
    @text.to_s
  end

  def self.generate
    new(FIFTY_PERCENT_CHANCE.call ? SECRETS.sample : "")
  end
end

class Characteristic
  MINIMUM_SCORE   = 1
  MAXIMUM_SCORE   = 100

  CHARACTERISTIC_PAIRS = [
    [:afraid,       :aggressive ],
    [:dry,          :humorous   ],
    [:introverted,  :extroverted]
  ]

  attr_reader :score, :minimum, :maximum

  def initialize(minimum, maximum)
    @minimum = minimum
    @maximum = maximum
  end

  def randomly_set
    @score = rand(MINIMUM_SCORE..MAXIMUM_SCORE)
    self
  end

  def self.generate
    CHARACTERISTIC_PAIRS.inject([]) do |characteristics, pair| 
      characteristics <<  new(pair[0], pair[1]).randomly_set
    end
  end

  def self.longest_minimum_length
    CHARACTERISTIC_PAIRS.map(&:first).flatten.map(&:length).max
  end
end

class Characteristics
  def initialize(characteristics)
    @characteristics = characteristics
  end

  def self.generate
    new(Characteristic.generate)
  end

  def each(&block)
    @characteristics.each(&block)
  end
end

class Character
  NAMES = [
    "Abrielle", 
    "Adair", 
    "Adara", 
    "Adriel", 
    "Aiyana", 
    "Alissa", 
    "Alixandra", 
    "Altair", 
    "Amara", 
    "Anatola", 
    "Anya", 
    "Arcadia", 
    "Ariadne", 
    "Arianwen", 
    "Aurelia", 
    "Aurelian", 
    "Aurelius", 
    "Avalon", 
    "Acalia", 
    "Alaire", 
    "Auristela", 
    "Bastian", 
    "Breena", 
    "Brielle", 
    "Briallan", 
    "Briseis", 
    "Cambria", 
    "Cara", 
    "Carys", 
    "Caspian", 
    "Cassia", 
    "Cassiel", 
    "Cassiopeia", 
    "Cassius", 
    "Chaniel", 
    "Cora", 
    "Corbin", 
    "Cyprian", 
    "Daire", 
    "Darius", 
    "Destin", 
    "Drake", 
    "Drystan", 
    "Dagen", 
    "Devlin", 
    "Devlyn", 
    "Eira", 
    "Eirian", 
    "Elysia", 
    "Eoin", 
    "Evadne", 
    "Eliron", 
    "Evanth", 
    "Fineas", 
    "Finian", 
    "Fyodor", 
    "Gareth", 
    "Gavriel", 
    "Griffin", 
    "Guinevere", 
    "Gaerwn", 
    "Ginerva", 
    "Hadriel", 
    "Hannelore", 
    "Hermione", 
    "Hesperos", 
    "Iagan", 
    "Ianthe", 
    "Ignacia", 
    "Ignatius", 
    "Iseult", 
    "Isolde", 
    "Jessalyn", 
    "Kara", 
    "Kerensa", 
    "Korbin", 
    "Kyler", 
    "Kyra", 
    "Katriel", 
    "Kyrielle", 
    "Leala", 
    "Leila", 
    "Lilith", 
    "Liora", 
    "Lucien", 
    "Lyra", 
    "Leira", 
    "Liriene", 
    "Liron", 
    "Maia", 
    "Marius", 
    "Mathieu", 
    "Mireille", 
    "Mireya", 
    "Maylea", 
    "Meira", 
    "Natania", 
    "Nerys", 
    "Nuriel", 
    "Nyssa", 
    "Neirin", 
    "Nyfain", 
    "Oisin", 
    "Oralie", 
    "Orion", 
    "Orpheus", 
    "Ozara", 
    "Oleisa", 
    "Orinthea", 
    "Peregrine", 
    "Persephone", 
    "Perseus", 
    "Petronela", 
    "Phelan", 
    "Pryderi", 
    "Pyralia", 
    "Pyralis", 
    "Qadira", 
    "Quintessa", 
    "Quinevere", 
    "Raisa", 
    "Remus", 
    "Rhyan", 
    "Rhydderch", 
    "Riona", 
    "Renfrew", 
    "Saoirse", 
    "Sarai", 
    "Sebastian", 
    "Seraphim", 
    "Seraphina", 
    "Sirius", 
    "Sorcha", 
    "Saira", 
    "Sarielle", 
    "Serian", 
    "Séverin", 
    "Tavish", 
    "Tearlach", 
    "Terra", 
    "Thalia", 
    "Thaniel", 
    "Theia", 
    "Torian", 
    "Torin", 
    "Tressa", 
    "Tristana", 
    "Uriela", 
    "Urien", 
    "Ulyssia", 
    "Vanora", 
    "Vespera", 
    "Vasilis", 
    "Xanthus", 
    "Xara", 
    "Xylia", 
    "Yadira", 
    "Yseult", 
    "Yakira", 
    "Yeira", 
    "Yeriel", 
    "Yestin", 
    "Zaira", 
    "Zephyr", 
    "Zora", 
    "Zorion", 
    "Zaniel", 
    "Zarek"
  ]
  attr_reader :name, :secret, :characteristics
  def initialize(name, secret, characteristics)
    @name            = name
    @secret          = secret
    @characteristics = characteristics
  end

  def self.generate
    new(NAMES.sample, Secret.generate, Characteristics.generate)
  end

  def has_secret?
    !secret.empty?
  end
end

class CharacterPrinter
  OUTPUT_WIDTH = 60

  def initialize(character, output = STDOUT)
    @character = character
    @output    = output
  end

  def print
    spacer
    spacer
    line
    center(@character.name)
    spacer

    if @character.has_secret?
      header("Secret")
      quote(@character.secret)
    end

    header("Characteristics")
    @character.characteristics.each do |characteristic|
      p ProgressBar.build(characteristic)
    end
    spacer
    spacer
    line
  end

  private

  def p(*args)
    args.each { |arg| @output.print("#{ arg }\n") }
  end

  def center(text)
    pad = Array.new((OUTPUT_WIDTH - text.length / 2), " ").join
    p "#{ pad }#{ text }#{ pad }"
  end

  def spacer
    p " " * OUTPUT_WIDTH
  end

  def line
    center("=" * OUTPUT_WIDTH)
    spacer
    spacer
  end

  def header(text)
    center(text.upcase)
    spacer
  end

  def quote(text)
    center"'#{ text }'"
    spacer
  end
end

class ProgressBar
  EMPTY = " "
  BAR   = "="

  def initialize(minimum, maximum, score)
    @minimum = minimum
    @maximum = maximum
    @score   = score
  end

  def self.build(characteristic)
    new(characteristic.minimum, characteristic.maximum, characteristic.score).build
  end

  def build
    "#{ @minimum } #{ pad } #{ bar }  #{ @maximum } (#{ @score })"
  end

  private

  def pad
    Array.new(Characteristic.longest_minimum_length - @minimum.length, EMPTY).join
  end

  def bar
    full_bar.concat(empty_bar).join
  end

  def full_bar
    Array.new(@score, BAR)
  end

  def empty_bar
    Array.new((Characteristic::MAXIMUM_SCORE - @score), EMPTY)
  end
end

CharacterPrinter.new(Character.generate).print
