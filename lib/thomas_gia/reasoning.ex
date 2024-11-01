defmodule ThomasGia.Reasoning do
  def get_people,
    do: [
      "Josh",
      "Thomas",
      "Ben",
      "Jack",
      "Greg",
      "Sam",
      "Lily",
      "Rachel",
      "Anna",
      "Jasmine",
      "Adrian",
      "Dennis",
      "Omar",
      "Max",
      "Kyle",
      "Elsa",
      "Ashley",
      "Tara",
      "Erika",
      "Bianca"
    ]

  def get_adverbs, do: ["is not as", "is"]

  def get_adjectives,
    do: [
      %{
        adjective: "adaptable",
        comparative: "more adaptable",
        antonym: "more unadapted"
      },
      %{
        adjective: "adventurous",
        comparative: "more adventurous",
        antonym: "more unadventurous"
      },
      %{
        adjective: "ambitious",
        comparative: "more ambitious",
        antonym: "more unambitious"
      },
      %{
        adjective: "diligent",
        comparative: "more diligent",
        antonym: "lazier"
      },
      %{
        adjective: "humble",
        comparative: "humbler",
        antonym: "prouder"
      },
      %{
        adjective: "courageous",
        comparative: "more courageous",
        antonym: "cowardlier"
      },
      %{
        adjective: "efficient",
        comparative: "more efficient",
        antonym: "more inefficient"
      },
      %{
        adjective: "generous",
        comparative: "more generous",
        antonym: "stingier"
      },
      %{
        adjective: "sincere",
        comparative: "sincerer",
        antonym: "more dishonest"
      },
      %{
        adjective: "trustworthy",
        comparative: "trustworthier",
        antonym: "untrustworthier"
      },
      %{
        adjective: "wise",
        comparative: "wiser",
        antonym: "foolish"
      },
      %{
        adjective: "reliable",
        comparative: "more reliable",
        antonym: "more unreliable"
      },
      %{
        adjective: "determined",
        comparative: "more determined",
        antonym: "more undetermined"
      },
      %{
        adjective: "strong",
        comparative: "stronger",
        antonym: "weaker"
      },
      %{
        adjective: "exceptional",
        comparative: "more exceptional",
        antonym: "less exceptional"
      },
      %{
        adjective: "kind",
        comparative: "kinder",
        antonym: "colder"
      },
      %{
        adjective: "persuasive",
        comparative: "more persuasive",
        antonym: "more dissuasive"
      },
      %{
        adjective: "witty",
        comparative: "wittier",
        antonym: "more serious"
      },
      %{
        adjective: "versatile",
        comparative: "more versatile",
        antonym: "less versatile"
      },
      %{
        adjective: "amazing",
        comparative: "more amazing",
        antonym: "less amazing"
      },
      %{
        adjective: "friendly",
        comparative: "friendlier",
        antonym: "more hostile"
      },
      %{
        adjective: "perseverant",
        comparative: "more perseverant",
        antonym: "less perseverant"
      },
      %{
        adjective: "modest",
        comparative: "more modest",
        antonym: "more arrogant"
      },
      %{
        adjective: "rational",
        comparative: "more rational",
        antonym: "more irrational"
      },
      %{
        adjective: "selfish",
        comparative: "selfisher",
        antonym: "more generous"
      },
      %{
        adjective: "sensible",
        comparative: "more sensible",
        antonym: "more ignorant"
      },
      %{
        adjective: "agile",
        comparative: "more agile",
        antonym: "clumsier"
      },
      %{
        adjective: "dramatic",
        comparative: "more dramatic",
        antonym: "more conservative"
      },
      %{
        adjective: "serious",
        comparative: "more serious",
        antonym: "funnier"
      },
      %{
        adjective: "dull",
        comparative: "duller",
        antonym: "smarter"
      },
      %{
        adjective: "loyal",
        comparative: "more loyal",
        antonym: "more disloyal"
      },
      %{
        adjective: "shy",
        comparative: "shyer",
        antonym: "bolder"
      },
      %{
        adjective: "mature",
        comparative: "more mature",
        antonym: "more immature"
      },
      %{
        adjective: "skinny",
        comparative: "skinnier",
        antonym: "fatter"
      },
      %{
        adjective: "slender",
        comparative: "slenderer",
        antonym: "chubbier"
      },
      %{
        adjective: "slim",
        comparative: "slimmer",
        antonym: "fatter"
      },
      %{
        adjective: "sloppy",
        comparative: "sloppier",
        antonym: "more careful"
      },
      %{
        adjective: "slow",
        comparative: "slower",
        antonym: "faster"
      },
      %{
        adjective: "smart",
        comparative: "smarter",
        antonym: "duller"
      },
      %{
        adjective: "motivated",
        comparative: "more motivated",
        antonym: "more disinterested"
      },
      %{
        adjective: "naive",
        comparative: "more naive",
        antonym: "more aware"
      },
      %{
        adjective: "sociable",
        comparative: "more sociable",
        antonym: "shier"
      },
      %{
        adjective: "beautiful",
        comparative: "more beautiful",
        antonym: "uglier"
      },
      %{
        adjective: "sophisticated",
        comparative: "more sophisticated",
        antonym: "more unsophisticated"
      },
      %{
        adjective: "faithful",
        comparative: "more faithful",
        antonym: "more unfaithful"
      },
      %{
        adjective: "nervous",
        comparative: "more nervous",
        antonym: "more patient"
      },
      %{
        adjective: "fearless",
        comparative: "more fearless",
        antonym: "cowardlier"
      },
      %{
        adjective: "noisy",
        comparative: "noisier",
        antonym: "quieter"
      },
      %{
        adjective: "brave",
        comparative: "braver",
        antonym: "cowardlier"
      },
      %{
        adjective: "bright",
        comparative: "brighter",
        antonym: "duller"
      },
      %{
        adjective: "old",
        comparative: "older",
        antonym: "younger"
      },
      %{
        adjective: "funny",
        comparative: "funnier",
        antonym: "more serious"
      },
      %{
        adjective: "optimistic",
        comparative: "more optimistic",
        antonym: "more pessimistic"
      },
      %{
        adjective: "calm",
        comparative: "more calm",
        antonym: "more agitated"
      },
      %{
        adjective: "straightforward",
        comparative: "more straightforward",
        antonym: "more devious"
      },
      %{
        adjective: "gentle",
        comparative: "gentler",
        antonym: "more brutal"
      },
      %{
        adjective: "passionate",
        comparative: "more passionate",
        antonym: "more half-hearted"
      },
      %{
        adjective: "patient",
        comparative: "more patient",
        antonym: "more agitated"
      },
      %{
        adjective: "cheerful",
        comparative: "more cheerful",
        antonym: "moodier"
      },
      %{
        adjective: "gorgeous",
        comparative: "more gorgeous",
        antonym: "uglier"
      },
      %{
        adjective: "chic",
        comparative: "chicher",
        antonym: "more unfashionable"
      },
      %{
        adjective: "childish",
        comparative: "more childish",
        antonym: "more mature"
      },
      %{
        adjective: "superficial",
        comparative: "more superficial",
        antonym: "more profound"
      },
      %{
        adjective: "talented",
        comparative: "more talented",
        antonym: "more ungifted"
      },
      %{
        adjective: "clever",
        comparative: "cleverer",
        antonym: "more stupid"
      },
      %{
        adjective: "clumsy",
        comparative: "clumsier",
        antonym: "more graceful"
      },
      %{
        adjective: "hesitant",
        comparative: "more hesitant",
        antonym: "more confident"
      },
      %{
        adjective: "communicative",
        comparative: "more communicative",
        antonym: "more uncommunicative"
      },
      %{
        adjective: "honest",
        comparative: "more honest",
        antonym: "more dishonest"
      },
      %{
        adjective: "tidy",
        comparative: "tidier",
        antonym: "messier"
      },
      %{
        adjective: "tired",
        comparative: "more tired",
        antonym: "fresher"
      },
      %{
        adjective: "tolerant",
        comparative: "more tolerant",
        antonym: "more intolerant"
      },
      %{
        adjective: "popular",
        comparative: "more popular",
        antonym: "more unpopular"
      },
      %{
        adjective: "confident",
        comparative: "more confident",
        antonym: "more insecure"
      },
      %{
        adjective: "immature",
        comparative: "more immature",
        antonym: "more mature"
      },
      %{
        adjective: "powerful",
        comparative: "more powerful",
        antonym: "weaker"
      },
      %{
        adjective: "pretty",
        comparative: "prettier",
        antonym: "uglier"
      },
      %{
        adjective: "impulsive",
        comparative: "more impulsive",
        antonym: "more cautious"
      },
      %{
        adjective: "prudent",
        comparative: "more prudent",
        antonym: "more imprudent"
      },
      %{
        adjective: "punctual",
        comparative: "more punctual",
        antonym: "tardier"
      },
      %{
        adjective: "creative",
        comparative: "more creative",
        antonym: "more uncreative"
      },
      %{
        adjective: "curious",
        comparative: "more curious",
        antonym: "less curious"
      },
      %{
        adjective: "independent",
        comparative: "more independent",
        antonym: "more dependent"
      },
      %{
        adjective: "quiet",
        comparative: "quieter",
        antonym: "noisier"
      },
      %{
        adjective: "realistic",
        comparative: "more realistic",
        antonym: "more unrealistic"
      },
      %{
        adjective: "delicate",
        comparative: "more delicate",
        antonym: "more insensitive"
      },
      %{
        adjective: "inventive",
        comparative: "more inventive",
        antonym: "more uninspired"
      },
      %{
        adjective: "respectful",
        comparative: "more respectful",
        antonym: "more disrespectful"
      },
      %{
        adjective: "irascible",
        comparative: "more irascible",
        antonym: "calmer"
      },
      %{
        adjective: "responsible",
        comparative: "more responsible",
        antonym: "more irresponsible"
      },
      %{
        adjective: "weak",
        comparative: "weaker",
        antonym: "stronger"
      },
      %{
        adjective: "ridiculous",
        comparative: "more ridiculous",
        antonym: "more serious"
      },
      %{
        adjective: "devoted",
        comparative: "more devoted",
        antonym: "more unloving"
      },
      %{
        adjective: "romantic",
        comparative: "more romantic",
        antonym: "more unsentimental"
      },
      %{
        adjective: "stubborn",
        comparative: "stubborner",
        antonym: "more docile"
      },
      %{
        adjective: "diplomatic",
        comparative: "more diplomatic",
        antonym: "more discourteous"
      },
      %{
        adjective: "sad",
        comparative: "sadder",
        antonym: "happier"
      },
      %{
        adjective: "happy",
        comparative: "happier",
        antonym: "sadder"
      },
      %{
        adjective: "young",
        comparative: "younger",
        antonym: "older"
      },
      %{
        adjective: "lazy",
        comparative: "lazier",
        antonym: "ambitious"
      },
      %{
        adjective: "chatty",
        comparative: "chattier",
        antonym: "shyer"
      },
      %{
        adjective: "lucky",
        comparative: "luckier",
        antonym: "more unfortunate"
      },
      %{
        adjective: "arrogant",
        comparative: "more arrogant",
        antonym: "humbler"
      },
      %{
        adjective: "tall",
        comparative: "taller",
        antonym: "shorter"
      },
      %{
        adjective: "short",
        comparative: "shorter",
        antonym: "taller"
      },
      %{
        adjective: "fat",
        comparative: "fatter",
        antonym: "thinner"
      }
    ]
end
