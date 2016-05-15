class SealsController < ApplicationController
  before_action :set_seal, only: [:show, :edit, :update, :destroy]
  before_action :ensure_signed_in

  # GET /seals
  # GET /seals.json
  def index
    @seals = owned_seals
  end

  # GET /seals/1
  # GET /seals/1.json
  def show
    param = params["stamp"]
    @seal = Seal.find_by(stamp: param)
    @view_auth = is_viewer?(@seal)
  end

  # GET /seals/new
  def new
    @seal = Seal.new
  end

  # GET /seals/1/edit
  def edit
  end

  # POST /seals
  # POST /seals.json
  def create
    users = seal_params["users"]
    user_params = process_users(users)
    @seal = Seal.new(text: seal_params["text"])
    @seal.stamp = BCrypt::Password.create(@seal.id).checksum.gsub(/[\.]/, '')
    respond_to do |format|
      if @seal.save
        @seal.seals_users << SealsUser.create(user_id: current_user.id,
                                              seal_id: @seal.id,
                                              owner: true)
        format.html { redirect_to controller: :seals,
                                  action: :show,
                                  stamp: @seal.stamp,
                                  notice: 'Seal was successfully created.' }
        format.json { render json: {stamp: @seal.stamp, status: "ok"} }
      else
        format.html { render :new }
        format.json { render json: @seal.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /seals/1
  # PATCH/PUT /seals/1.json
  def update
    respond_to do |format|
      if @seal.update(seal_params)
        format.html { redirect_to @seal, notice: 'Seal was successfully updated.' }
        format.json { render :show, status: :ok, location: @seal }
      else
        format.html { render :edit }
        format.json { render json: @seal.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /seals/1
  # DELETE /seals/1.json
  def destroy
    @seal.destroy
    respond_to do |format|
      format.html { redirect_to seals_url, notice: 'Seal was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
  # Use callbacks to share common setup or constraints between actions.
  def set_seal
    @seal = Seal.find_by(stamp: params[:stamp])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def seal_params
    params.fetch(:seal)
  end

  def is_viewer?(seal)
    current_user.seals.exists?(seal.id)
  end

  def owned_seals
    current_user.owned_seals
  end

  def all_users_not_nil?(user_params)
    user_params.all? { |user| !user.id.nil?}
  end

  def user_param(id, name, verifier, terminator)
    if id.nil?
      {id: nil, name: name}
    else
      {id: id, name: name, verifier: verifier, terminator: terminator}
    end
  end

  def process_users(users)
    if users.nil?
      []
    else
      users.collect { |user| user_param(User.find_by(name: user.username),
                                        user.username,
                                        user.verifier,
                                        user.terminator)}
    end
  end
end
