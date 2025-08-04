import React, {useEffect, useRef, useState} from 'react';
import {Modal} from "antd";
import Draggable, {DraggableData, DraggableEvent} from 'react-draggable';
import {AiProChat, ChatMessage} from "../AiProChat/AiProChat";
import {useSseWithEvent} from "../../hooks/useSseWithEvent.ts";
import {useGetManual} from "../../hooks/useApis.ts";

type AiChatModalProps = {
    open: boolean,
    onClose?: () => void
}

const AiChatModal: React.FC<AiChatModalProps> = ({open, onClose}) => {

    const {start: doStart} = useSseWithEvent("/api/v1/system/bot/chat");
    const [disabled, setDisabled] = useState(true);
    const [bounds, setBounds] = useState({left: 0, top: 0, bottom: 0, right: 0});
    const draggleRef = useRef<HTMLDivElement>(null);

    const onStart = (_event: DraggableEvent, uiData: DraggableData) => {
        const {clientWidth, clientHeight} = window.document.documentElement;
        const targetRect = draggleRef.current?.getBoundingClientRect();
        if (!targetRect) {
            return;
        }
        setBounds({
            left: -targetRect.left + uiData.x,
            right: clientWidth - (targetRect.right - uiData.x),
            top: -targetRect.top + uiData.y,
            bottom: clientHeight - (targetRect.bottom - uiData.y),
        });
    };

    const [chats, setChats] = useState<ChatMessage[]>([]);

    const {doGet: clearMessage} = useGetManual("/api/v1/system/bot/clearMessage");
    const handleClearMessage = () => {
        setChats([])
        localStorage.removeItem("localBotChats")

        clearMessage().then();
    }

    useEffect(() => {
        const item = localStorage.getItem("localBotChats");

        if (item) {
            const chatsFromLocal = JSON.parse(item);
            setChats(chatsFromLocal)
        } else {
            setChats([])
        }
    }, [])


    return (
        <Modal
            styles={{
                body: {
                    margin: "10px -24px -24px -24px",
                },
                footer: {display: "none"}
            }}
            title={
                <div
                    style={{
                        width: '100%',
                        cursor: 'move',
                    }}
                    onMouseOver={() => {
                        if (disabled) {
                            setDisabled(false);
                        }
                    }}
                    onMouseOut={() => {
                        setDisabled(true);
                    }}
                    onFocus={() => {
                    }}
                    onBlur={() => {
                    }}
                >
                    AIFlowy 智能助理
                </div>
            }
            footer={<></>}
            open={open}
            onCancel={onClose}
            afterOpenChange={(value) => {
                if (value) {
                    const item = localStorage.getItem("localBotChats");

                    if (item) {
                        const chatsFromLocal = JSON.parse(item);
                        setChats(chatsFromLocal)
                    } else {
                        setChats([])
                    }
                }else {
                    setChats([])
                }
            }}
            modalRender={(modal) => (
                <Draggable
                    disabled={disabled}
                    bounds={bounds}
                    nodeRef={draggleRef}
                    onStart={(event, uiData) => onStart(event, uiData)}
                >
                    <div ref={draggleRef} style={{width: "600px"}}>{modal}</div>
                </Draggable>
            )}
        >
            <AiProChat
                style={{border: "1px solid #f3f3f3", height: "680px",}}
                helloMessage="欢迎使用 AIFlowy ，我是你的智能助理，有什么问题可以随时问我。"
                isLocalBot={true}
                chats={chats}
                onChatsChange={setChats}
                clearMessage={handleClearMessage}
                request={async (messages) => {
                    const readableStream = new ReadableStream({
                        async start(controller) {
                            const encoder = new TextEncoder();

                            doStart({
                                data: {
                                    topicId: 1,
                                    prompt: messages[messages.length - 1].content as string,
                                },
                                onMessage: (msg) => {
                                    // 直接传递消息，不进行额外处理
                                    controller.enqueue(encoder.encode(msg));
                                },
                                onError: (error) => {
                                    console.error('SSE 连接错误:', error);
                                    controller.error(error);
                                },
                                onFinished: () => {
                                    controller.close();
                                }
                            });
                        },
                    });
                    return new Response(readableStream);
                }}
            />
        </Modal>
    );
};

export default AiChatModal;
