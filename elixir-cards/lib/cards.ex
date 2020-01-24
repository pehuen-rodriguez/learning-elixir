defmodule Cards do
  @moduledoc """
  Provides methods for creating and handling a deck of cards
  """

  @doc """
  Creates a deck.

  ## Examples

      iex> Cards.create_deck()
      ["Ace of Spades", "Two of Spades", "Three of Spades", "Four of Spades",
      "Five of Spades", "Ace of Clubs", "Two of Clubs", "Three of Clubs",
      "Four of Clubs", "Five of Clubs", "Ace of Hearts", "Two of Hearts",
      "Three of Hearts", "Four of Hearts", "Five of Hearts",
      "Ace of Diamonds", "Two of Diamonds", "Three of Diamonds",
      "Four of Diamonds", "Five of Diamonds"]

  """
  def create_deck do
    values = ["Ace", "Two", "Three", "Four", "Five"]
    suits = ["Spades", "Clubs", "Hearts", "Diamonds"]

    for suit <- suits, value <- values do
      "#{value} of #{suit}"
    end
  end

  @doc """
  Gets a deck and returns a new randomly shuffled list with the
  same number of records.

  ## Examples

      deck = Cards.shuffle(deck)
      Cards.shuffle(deck)
      ["Five of Spades", "Four of Hearts", "Four of Diamonds", "Ace of Hearts",
      "Four of Spades", "Five of Clubs", "Five of Hearts", "Three of Clubs",
      "Three of Diamonds", "Three of Hearts", "Four of Clubs", "Ace of Spades",
      "Two of Hearts", "Two of Clubs", "Ace of Clubs", "Five of Diamonds",
      "Two of Diamonds", "Ace of Diamonds", "Two of Spades", "Three of Spades"]

  """
  def shuffle(deck) do
    Enum.shuffle(deck)
  end

  @doc """
  Determines wether a deck contains a given card.

  ## Examples

      iex> deck = Cards.create_deck
      iex> Cards.contains?(deck, "King of Spades")
      false

      iex> deck = Cards.create_deck
      iex> Cards.contains?(deck, "Four of Hearts")
      true

  """
  def contains?(deck, card) do
    Enum.member?(deck, card)
  end

  @doc """
  Divides a deck into a hand and the remainder of the deck.
  The `hand_size` argument indicates how many cards should
  be in the hand.

  ## Examples

      iex> deck = Cards.create_deck
      iex> {hand, _deck} = Cards.deal(deck, 2)
      iex> hand
      ["Ace of Spades", "Two of Spades"]

  """
  def deal(deck, hand_size) do
    Enum.split(deck, hand_size)
  end

  @doc """
  Saves the deck to a file on the HD.

  ## Examples

      Cards.save(deck, filename)
      { deck, "myDeck" }

  """
  def save(deck, filename) do
    binary = :erlang.term_to_binary(deck)
    File.write(filename, binary)
  end

  @doc """
  Loads the deck from a file on the HD.

  ## Examples

      Cards.load(filename)
      { deck }

  """
  def load(filename) do
    case File.read(filename) do
      {:ok, binary} -> :erlang.binary_to_term(binary)
      {:error, _reason}  -> "That file does not exists"
    end
  end

  @doc """
  Pipelines common used methods and give a hand.

  ## Examples

      Cards.create_hand(hand_size)
      { *hand*, *deck* }
      {["Ace of Spades", "Two of Heards"], [rest of deck]]}

  """
  def create_hand(hand_size) do
    Cards.create_deck
    |> Cards.shuffle
    |> Cards.deal(hand_size)
  end
end
