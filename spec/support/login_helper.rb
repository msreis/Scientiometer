def token(account)
  JsonWebToken.encode(account_id: account.id)
end
