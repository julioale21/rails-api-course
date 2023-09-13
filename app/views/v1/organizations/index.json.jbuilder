json.data do 
    json.array! organizations do |organization|
        json.partial! 'v1/organizations/organization', locals: { organization: organization }
    end
end