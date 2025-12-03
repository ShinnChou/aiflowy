export const tryit = async <Return>(
  func: Promise<Return>,
): Promise<[Error, null] | [null, Return]> => {
  try {
    const result = await func.then();
    return [null, result];
  } catch (error) {
    return [error as Error, null];
  }
};
