class UserreviewsController < ApplicationController
  # GET /userreviews
  # GET /userreviews.xml
  def index
    @userreviews = Userreview.find(:all)

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @userreviews }
    end
  end

  # GET /userreviews/1
  # GET /userreviews/1.xml
  def show
    @userreview = Userreview.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @userreview }
    end
  end

  # GET /userreviews/new
  # GET /userreviews/new.xml
  def new
    @userreview = Userreview.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @userreview }
    end
  end

  # GET /userreviews/1/edit
  def edit
    @userreview = Userreview.find(params[:id])
  end

  # POST /userreviews
  # POST /userreviews.xml
  def create
    @userreview = Userreview.new(params[:userreview])

    respond_to do |format|
      if @userreview.save
        flash[:notice] = 'Userreview was successfully created.'
        format.html { redirect_to(@userreview) }
        format.xml  { render :xml => @userreview, :status => :created, :location => @userreview }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @userreview.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /userreviews/1
  # PUT /userreviews/1.xml
  def update
    @userreview = Userreview.find(params[:id])

    respond_to do |format|
      if @userreview.update_attributes(params[:userreview])
        flash[:notice] = 'Userreview was successfully updated.'
        format.html { redirect_to(@userreview) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @userreview.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /userreviews/1
  # DELETE /userreviews/1.xml
  def destroy
    @userreview = Userreview.find(params[:id])
    @userreview.destroy

    respond_to do |format|
      format.html { redirect_to(userreviews_url) }
      format.xml  { head :ok }
    end
  end
end
