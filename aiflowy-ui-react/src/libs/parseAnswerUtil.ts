
export function parseAnswerUtil(text: string) {
    const result = {
        thought: '',
        action: '',
        actionInput: '',
        finalAnswer: ''
    };

    // 使用正则表达式匹配各个部分，保留前缀
    // 匹配 🧠 Thought: 或 Thought: 开头的内容
    const thoughtMatch = text.match(/((?:🧠\s*)?Thought:\s*.*?)(?=\n\n|(?:\n(?:Action:|Final Answer:))|$)/s);

    // 匹配 Action: 开头的内容
    const actionMatch = text.match(/(Action:\s*.*?)(?=\n\n|(?:\nAction Input:)|$)/s);

    // 匹配 Action Input: 开头的内容
    const actionInputMatch = text.match(/(Action Input:\s*.*?)(?=\n\n|(?:\nFinal Answer:)|$)/s);

    // 匹配 ✅ Final Answer: 或 Final Answer: 开头的内容
    const finalAnswerMatch = text.match(/((?:✅\s*)?Final Answer:\s*.*?)$/s);

    if (thoughtMatch) {
        result.thought = thoughtMatch[1].trim();
    }

    if (actionMatch) {
        result.action = actionMatch[1].trim();
    }

    if (actionInputMatch) {
        result.actionInput = actionInputMatch[1].trim();
    }

    if (finalAnswerMatch) {
        result.finalAnswer = finalAnswerMatch[1].trim();
    }

    return result;
}



export function processArray(arr: any) {
    if (!arr || arr.length === 0) return [];

    const groups = [];
    let currentGroup = [];

    // 辅助函数：获取item的type值
    const getItemType = (item: any) => {
        return item.options?.type ?? 0;
    };

    // 按照type=1进行分组
    for (let i = 0; i < arr.length; i++) {
        const item = arr[i];
        const itemType = getItemType(item);

        if (itemType === 1) {
            // 如果当前组不为空，保存当前组
            if (currentGroup.length > 0) {
                groups.push([...currentGroup]);
            }
            // 开始新的组
            currentGroup = [item];
        } else {
            // 将非type=1的元素添加到当前组
            currentGroup.push(item);
        }
    }

    // 处理最后一组
    if (currentGroup.length > 0) {
        groups.push(currentGroup);
    }

    // 处理每个组，合并非type=1的对象
    const result = groups.map(group => {
        const typeOneItems = group.filter(item => getItemType(item) === 1);
        const nonTypeOneItems = group.filter(item => getItemType(item) !== 1);

        if (nonTypeOneItems.length === 0) {
            // 如果组中没有非type=1的元素，直接返回type=1的元素
            return typeOneItems;
        }

        // 合并非type=1的对象
        const firstNonTypeOne = nonTypeOneItems[0];
        const mergedContent = nonTypeOneItems
            .map(item => item.content)
            .join('\n');

        const mergedItem = {
            content: mergedContent,
            created: firstNonTypeOne.created,
            id: firstNonTypeOne.id,
            role: firstNonTypeOne.role,
            options: firstNonTypeOne.options
        };

        // 返回type=1的元素和合并后的元素
        return [...typeOneItems, mergedItem];
    });

    // 扁平化结果
    return result.flat();
}