require 'rails_helper'

RSpec.describe Expense, type: :model do
  let(:category) { Category.create!(name: "Food") }

  describe "validations" do
    it "is valid with valid attributes" do
      expense = Expense.new(
        description: "Lunch",
        amount: 100.00,
        category: category,
        date: Date.current
      )
      expect(expense).to be_valid
    end

    it "is invalid without a description" do
      expense = Expense.new(
        description: "",
        amount: 100.00,
        category: category,
        date: Date.current
      )
      expect(expense).not_to be_valid
      expect(expense.errors[:description]).to include("can't be blank")
    end

    it "is invalid with negative amount" do
      expense = Expense.new(
        description: "Lunch",
        amount: -100.00,
        category: category,
        date: Date.current
      )
      expect(expense).not_to be_valid
      expect(expense.errors[:amount]).to be_present
    end

    it "is invalid with zero amount" do
      expense = Expense.new(
        description: "Lunch",
        amount: 0,
        category: category,
        date: Date.current
      )
      expect(expense).not_to be_valid
      expect(expense.errors[:amount]).to be_present
    end

    it "is invalid with future date" do
      expense = Expense.new(
        description: "Lunch",
        amount: 100.00,
        category: category,
        date: 1.day.from_now
      )
      expect(expense).not_to be_valid
      expect(expense.errors[:date]).to include("cannot be in the future")
    end

    it "is valid with today's date" do
      expense = Expense.new(
        description: "Lunch",
        amount: 100.00,
        category: category,
        date: Date.current
      )
      expect(expense).to be_valid
    end
  end
end
