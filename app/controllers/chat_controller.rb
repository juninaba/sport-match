class ChatController < ApplicationController
  def create
    # 自分の持っているチャットルームを取得
    current_user_chat_rooms = RoomUser.where(user_id: current_user.id).map(&:room)
    # 自分の持っているチャットルームからチャット相手のいるルームを探す
    chat_room = RoomUser.where(room: current_user_chat_rooms, user_id: params[:user_id]).map(&:room).first
    # なければ作成する
    if chat_room.blank?
      # chat_roomsテーブルにレコードを作成
      chat_room = Room.create
      RoomUser.create(room: chat_room, user_id: current_user.id)
      RoomUser.create(room: chat_room, user_id: params[:user_id])
    end
    # チャットルームへ遷移させる
    redirect_to action: :show, id: chat_room.id
  end

  def show
    # チャット相手の情報を取得する
    chat_room = Room.find_by(id: params[:id])
    @room_user = chat_room.room_users.
      where.not(user_id: current_user.id).first.user
    @room_messages = RoomMessage.where(room: chat_room).order(:created_at)
  end
end
