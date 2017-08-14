class CustomerSearchTerm
  attr_reader :where_clause, :where_args, :order, :first_term, :second_term

  def initialize(search_term)
    search_term = search_term.downcase
    @where_clause = ''
    @where_args = {}
    if search_term =~ /@/
      build_for_email_search(search_term)
    elsif single_search_term?(search_term)
      build_for_name_search(search_term)
    else
      build_for_full_name_search(search_term)
    end
  end

  private

  def build_for_name_search(search_term)
    @where_clause << case_insensitive_search(:first_name)
    @where_args[:first_name] = starts_with(search_term)
    @where_clause << " OR #{case_insensitive_search(:last_name)}"
    @where_args[:last_name] = starts_with(search_term)
    @where_clause << " OR #{case_insensitive_search(:username)}"
    @where_args[:username] = starts_with(search_term)
    @order = 'last_name asc'
  end

  def build_for_full_name_search(search_term)
    @first_term = truncate_first_term(search_term)
    @second_term = truncate_second_term(search_term)
    @where_clause << case_insensitive_in_search(:first_name, @first_term, @second_term)
    @where_args[:first_name] = @first_term
    @where_clause << " AND (#{case_insensitive_in_search(:last_name, @first_term, @second_term)})"
    @where_args[:last_name] = @second_term
  end

  def single_search_term?(search_term)
    !search_term.strip.include? ' '
  end

  def truncate_first_term(search_term)
    search_term.split(' ')[0..0].join(' ')
  end

  def truncate_second_term(search_term)
    search_term.split(' ')[1..1].join(' ')
  end

  def starts_with(search_term)
    search_term + '%'
  end

  def case_insensitive_search(field_name)
    "lower(#{field_name}) like :#{field_name}"
  end

  def case_insensitive_in_search(field_name, args1, args2)
    "lower(#{field_name}) in ('#{args1}', '#{args2}')"
  end

  def extract_name(email)
    email.gsub(/@.*$/, '').gsub(/[0-9]+/, '')
  end

  def build_for_email_search(search_term)
    @where_clause << case_insensitive_search(:first_name)
    @where_args[:first_name] = starts_with(extract_name(search_term))

    @where_clause << " OR #{case_insensitive_search(:last_name)}"
    @where_args[:last_name] = starts_with(extract_name(search_term))

    @where_clause << " OR #{case_insensitive_search(:email)}"
    @where_args[:email] = search_term

    @order = 'lower(email) = ' + ActiveRecord::Base.connection.quote(search_term) + ' desc, last_name asc'
  end
end
