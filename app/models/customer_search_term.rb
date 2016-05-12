class CustomerSearchTerm
	attr_reader :where_clause, :where_args, :order 

	def initialize(search_term)
		search_term = search_term.downcase @where_clause = ""
		@where_args = {}
		if search_term =~ /@/
		  build_for_email_search(search_term)
		else
		  build_for_name_search(search_term)
		end
	end

	def build_for_email_search(search_term)
		@where_clause << case_insensitive_search(:first_name) 
		@where_args[:first_name] = starts_with(extract_name(search_term))

		@where_clause << " OR #{case_insensitive_search(:last_name)}" 
		@where_args[:last_name] = starts_with(extract_name(search_term))

		@where_clause << " OR #{case_insensitive_search(:email)}" 
		@where_args[:email] = search_term
		
		@order = "lower(email) = " + ActiveRecord::Base.connection.quote(search_term) + " desc, last_name asc"
	end 
end