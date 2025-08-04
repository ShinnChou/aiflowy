import React, {useEffect, useState} from 'react';
import {Alert, Form, FormInstance, Input, Select} from "antd";
import OptionsPage from "../../components/OptionsPage";
import {useLayout} from "../../hooks/useLayout.tsx";
import './styles/settings.css'
import {useGetManual} from "../../hooks/useApis.ts";


type LlmOption = {
    label: string;
    value: string;
    extra: Map<string, string>;
};

const Settings: React.FC = () => {
    const {setOptions} = useLayout();


    const {doGet:getLlmBrandList} = useGetManual("/api/v1/aiLlmBrand/list");

    const [llmSelectItems,setLlmSelectItems] = useState<Array<LlmOption>>([]);

    const [currentLlm,setCurrentLlm] = useState<LlmOption | undefined>();

    const [form,setForm] = useState<FormInstance | undefined>();

    useEffect(() => {
        setOptions({
            showBreadcrumb: true,
            breadcrumbs: [
                {title: '首页'},
                {title: '系统设置'}
            ],
        })

        getLlmBrandList().then((res) => {
            if(res?.data.errorCode == 0){
                const llmList = res.data.data.map((item: { options:any; title: string; key: string; }) => {
                    const extra:Map<string,string> = new Map<string, string>();
                    extra.set("llmEndpoint",item.options.llmEndpoint);
                    extra.set("chatPath",item.options.chatPath);

                    return {
                        label:item.title,
                        value:item.key,
                        extra:extra
                    } as LlmOption
                });

                setLlmSelectItems(llmList);
            }
        });

        return () => {
            setOptions({
                showBreadcrumb: true,
                breadcrumbs: []
            })
        }
    }, [])

    const handleLlmChange = (
        _value: LlmOption,
        option?: LlmOption | LlmOption[] | undefined
    ) => {
        if (option && !Array.isArray(option)) {
            setCurrentLlm(option);
            form?.setFieldsValue({
                chatgpt_endpoint: option.extra.get("llmEndpoint"),
                chatgpt_chatPath: option.extra.get("chatPath"),
                chatgpt_api_key: "",
                chatgpt_model_name: "",
                model_of_chat:option.value
            });
        } else {
            setCurrentLlm(undefined);
        }

    };

    const handleOnFormReady = (formInstance: FormInstance) => {
        setForm(formInstance)
    }

    return (
        <OptionsPage style={{
            overflowY: 'auto'}} onFormReady={handleOnFormReady}>
                <div className="settings-model-container">
                    <div className="settings-model-title">大模型配置</div>
                    <Form.Item label="对话模型供应商" labelCol={{span:3}} name="model_of_chat" className="settings-model-item">
                        <Select
                            allowClear
                            showSearch
                            placeholder={"选择对话模型供应商"}
                            value={currentLlm}
                            options={llmSelectItems}
                            filterOption={(input, option) => {
                                return ((option?.label ?? '') as string).toLowerCase().includes(input.toLowerCase())
                            }}
                            onChange={handleLlmChange}
                        />
                    </Form.Item>
                </div>

                <div style={{marginTop: 24, }} className="settings-model-container">
                    <div className="settings-model-title">对话模型配置</div>
                    <Form.Item style={{marginTop: 24}}>
                        <Alert
                            message="注意：有很多大模型（比如：暗月之面等）都是兼容 ChatGPT 的，因此若需要配置系统未内置的平台的大模型，供应商可以选择OpenAi。"
                            type="info"/>
                    </Form.Item>

                    <Form.Item label="Endpoint" name="chatgpt_endpoint">
                        <Input placeholder="请输入大模型接入地址"  />
                    </Form.Item>

                    <Form.Item label="chatPath" name="chatgpt_chatPath">
                        <Input placeholder="请输入大模型聊天路径"  />
                    </Form.Item>

                    <Form.Item label="ApiKey" name="chatgpt_api_key">
                        <Input placeholder="请输 Api Key"/>
                    </Form.Item>

                    <Form.Item label="模型名称" name="chatgpt_model_name">
                        <Input placeholder="请输入模型名称"/>
                    </Form.Item>
                </div>


        </OptionsPage>
    );
};


export default {
    path: "sys/settings",
    element: Settings
};