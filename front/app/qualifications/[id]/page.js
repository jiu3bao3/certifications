import Link from "next/link"

const getQualification = async(id) => {
    const response = await fetch(`${process.env.REACT_APP_API_ENDPOINT}/qualifications/${id}`, {
        method: "GET",
        headers : {
            "Accept": "application/json",
            "Content-Type" : "application/json"
        }
    })
    const json = await response.json();
    return json;
}

const Qualification = async(context) => {
    const param = await context.params;
    const qualification = await getQualification(param.id);
    const grades = await qualification.grades;
    return(
        <div>
          <h1>{qualification.name_ja}</h1>
          <div>
            <Link href={`${process.env.NEXT_PUBLIC_URL}/`}>一覧</Link>
            <table>
                <thead>
                    <tr>
                        <th>項目</th>
                        <th>内容</th>
                    </tr>
                </thead>
                <tbody>
                    <tr>
                        <th>資格名</th>
                        <td>{qualification.name_ja}</td>
                    </tr>
                    <tr>
                        <th>資格英語名</th>
                        <td>{qualification.name_en}</td>
                    </tr>
                    <tr>
                        <th>区分</th>
                        <td>{qualification.classification}</td>
                    </tr>
                    <tr>
                        <th>カテゴリー</th>
                        <td>{qualification.category}</td>
                    </tr>
                    <tr>
                        <th>説明</th>
                        <td></td>
                    </tr>
                </tbody>
            </table>
            <Link href={`${process.env.NEXT_PUBLIC_URL}/`}>一覧</Link>
          </div>
          <h2>グレード</h2>
          <div>
            <Link href={`${process.env.NEXT_PUBLIC_URL}/grades/new`}>グレード作成</Link>
          </div>
          <table>
            <thead>
                <tr>
                  <th>グレード名</th>
                  <th>説明</th>
                  <th>資格認定機関</th>
                  <th>試験実施機関</th>
                  <th>編集</th>
                  <th>削除</th>
                </tr>
            </thead>
            <tbody>
                {grades.map((g, idx) => 
                    <tr key={g.id} className={idx % 2 == 0 ? 'even' : 'odd'}>
                        <td>{g.grade_name}</td>
                        <td>{g.description}</td>
                        <td>{g.certificater_name}</td>
                        <td>{g.examiner_name}</td>
                        <td><Link href={`${process.env.NEXT_PUBLIC_URL}/grades/${g.id}/edit`}>編集</Link></td>
                        <td><button>削除</button></td>
                    </tr>
                )}
            </tbody>
          </table>
        </div>
    )
}
export default Qualification
