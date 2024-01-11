import asyncio


async def perform_simple_operation():
    while True:
        _ = 42 * 42
        await asyncio.sleep(1)


async def main():
    num_tasks = 1000000
    tasks = []

    for _ in range(num_tasks):
        task = asyncio.create_task(perform_simple_operation())
        tasks.append(task)

    await asyncio.gather(*tasks)

if __name__ == "__main__":
    asyncio.run(main())
