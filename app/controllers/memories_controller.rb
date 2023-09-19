class MemoriesController < ApplicationController
  before_action :require_login
  before_action :set_memory, only: [:show, :edit, :update, :destroy]
  before_action :authorize_memory_access, only: %i[show edit update destroy]
  before_action :set_event_options, only: [:new, :edit, :update]
  
  def index
    # 現在のユーザーが所属する家族のユーザーを取得
    family_users = User.where(family_id: current_user.family_id)
  
    # これらのユーザーが作成したイベントを取得
    family_events = Event.where(user_id: family_users.ids)
  
    # everyoneのvisibilityを持つイベントに関連するメモリーを取得
    everyone_events = family_events.where(visibility: "everyone")
    @memories = Memory.with_attached_photos.where(event: everyone_events)
  
    # partialのvisibilityを持つイベントに関連するメモリーを取得
    partial_events = family_events.joins(:visible_to_users).where(visibility: "partial", event_visibilities: { user_id: current_user.id })
    @memories = @memories.or(Memory.with_attached_photos.where(event: partial_events))
  
    # 現在のユーザーに表示可能なイベントのみをフィルタリング
    @events = family_events.select { |event| event.visible_to(current_user) }
  end  

  def show;
  end

  def edit
    set_event_options
  end

  def new
    @memory = Memory.new
    set_event_options
  end

  def create
    @memory = Memory.new(memory_params)
    if @memory.save
      flash[:notice] = 'メモリーを作成しました！'
      redirect_to @memory
    else
      render :new, status: :unprocessable_entity
    end
  end

  def update
    if params[:memory][:photos]
      @memory.photos.attach(params[:memory][:photos])
      params[:memory].delete(:photos)
    end
    if @memory.update(memory_params)
      redirect_to @memory, notice: "メモリーを更新しました！"
    else
      flash[:alert] = @memory.errors.full_messages.join(", ")
      render :edit
    end
  end
  

  def destroy
    @memory.destroy
    flash[:notice] = 'メモリーを削除しました！'
    redirect_to memories_path
  end
  
  

  def delete_photo
    set_memory
    photo = ActiveStorage::Attachment.find(params[:photo_id])
    photo.purge
    redirect_to edit_memory_path(@memory), notice: "写真を削除しました！"
  end

  private

  def set_memory
    @memory = Memory.with_attached_photos.find(params[:id])
  end


  def set_event_options
    # 現在のユーザーが所属する家族のユーザーを取得
    family_users = User.where(family_id: current_user.family_id)
  
    # これらのユーザーが作成したイベントを取得
    family_events = Event.where(user_id: family_users.ids)
  
    # 現在のユーザーに表示可能なイベントのみをフィルタリング
    @events = family_events.select { |event| event.visible_to(current_user) }
  
    # イベントの選択肢を設定
    @event_options = @events.map { |event| [event.title, event.id] }
  end    

  def memory_params
    params.require(:memory).permit(:title, :details, :date, :event_id, :event_type, photos: [])
  end
  
  def authorize_memory_access
    # メモリーのイベントに関連するアクセス制限
    if !@memory.event.visible_to(current_user)
      flash[:alert] = 'アクセス権限がありません'
      redirect_to memories_path
      return
    end
  
    # メモリーが現在のユーザーの家族に関連しているかの確認
    unless User.find(@memory.event.user_id).family == current_user.family
      flash[:alert] = 'アクセス権限がありません'
      redirect_to memories_path
      return
    end
  end  
end
