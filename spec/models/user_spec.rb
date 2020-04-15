require 'rails_helper'
describe User do
  describe '#create' do

    it "nameとemailとpasswordとpassword_confirmationが存在すれば登録できること" do
      user = build(:user)
      expect(user).to be_valid
    end

    it "nameがない場合は登録できないこと" do
      user = build(:user, name: "")
      user.valid?
      expect(user.errors[:name]).to include("を入力してください")
    end

    it "emailがない場合は登録できないこと" do
      user = build(:user, email: "")
      user.valid?
      expect(user.errors[:email]).to include("を入力してください")
    end

    it "passwordがない場合は登録できないこと" do
      user = build(:user, password: "")
      user.valid?
      expect(user.errors[:password]).to include("を入力してください")
    end

    it "passwordが存在してもpassword_confirmationがない場合は登録できないこと" do
      user = build(:user, password_confirmation: "")
      user.valid?
      expect(user.errors[:password_confirmation]).to include("とパスワードの入力が一致しません")
    end

    it "nameが7文字以上であれば登録できないこと" do
      user = build(:user, name: "kokokok")
      user.valid?
      expect(user.errors[:name]).to include("は6文字以内で入力してください")
    end

    it "nameが6文字以下では登録できること" do
      user = build(:user, name: "kokoko")
      expect(user).to be_valid
    end

    it "重複したemailが存在する場合登録できないこと" do
      user = create(:user)
      another_user = build(:user)
      another_user.valid?
      expect(another_user.errors[:email]).to include("はすでに存在します")
    end

    it "passwordが6文字以上であれば登録できること" do
      user = build(:user, password: "111111", password_confirmation: "111111")
      expect(user).to be_valid
    end

    it "passwordが5文字以下であれば登録できないこと" do
      user = build(:user, password: "11111", password_confirmation: "11111")
      user.valid?
      expect(user.errors[:password]).to include("は6文字以上で入力してください")
    end

  end
end